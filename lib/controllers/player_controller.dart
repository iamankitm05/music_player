import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/constants/app_constants.dart';
import 'package:music_player/models/player_position_data.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class PlayerController extends GetxController {
  final _storage = Get.find<GetStorage>();
  final _onAudioQuery = OnAudioQuery();

  final permissionsStatus = false.obs;

  final selectedSong = Rxn<SongModel>();
  final shuffleingOn = false.obs;
  final Rx<PlayMode> playMode = PlayMode.repeat.obs;
  final _player = AudioPlayer();
  StreamSubscription? _selectedSongStreamSubscription;

  final isSongsLoading = false.obs;
  final songs = <SongModel>[].obs;

  final filteredSongs = [].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final permissionsStatus = await getPermissionsStatus();
    if (permissionsStatus) {
      await getSongs();
      shuffleingOn.value =
          _storage.read<bool>(AppConstants.shuffleingOnKey) ?? false;
      final playModeIndex =
          _storage.read<int>(AppConstants.playModeKey) ?? PlayMode.repeat.index;
      playMode.value = PlayMode.values[playModeIndex];
      final songId = _storage.read<int>(AppConstants.selectedSongIdKey);
      if (songId != null) {
        for (final song in songs) {
          if (songId == song.id) {
            await selectSong(song);
          }
        }
      }
    }
  }

  @override
  void onClose() {
    _player.dispose();
    _selectedSongStreamSubscription?.cancel();
  }

  Future<bool> getPermissionsStatus() async {
    permissionsStatus.value = await _onAudioQuery.permissionsStatus();
    return permissionsStatus.value;
  }

  Future<bool> permissionsRequest() async {
    permissionsStatus.value = await _onAudioQuery.permissionsRequest();
    if (permissionsStatus.value) {
      await getSongs();
    }
    return permissionsStatus.value;
  }

  Future<void> selectSong(SongModel? song) async {
    selectedSong.value = song;
    if (selectedSong.value != null) {
      await _player.setFilePath(selectedSong.value!.data);
      _listenSongChanges();
      _storage.write(AppConstants.selectedSongIdKey, selectedSong.value!.id);
    }
  }

  void _listenSongChanges() {
    _selectedSongStreamSubscription =
        _player.processingStateStream.listen((processingState) {
      if (processingState == ProcessingState.completed) {
        if (playMode.value == PlayMode.single) {
          seek(Duration.zero);
        } else if (playMode.value == PlayMode.repeat) {
          _selectedSongStreamSubscription?.cancel();
          _selectedSongStreamSubscription = null;
          if (shuffleingOn.value) {
            selectRandomSong();
          } else {
            selectNextSong();
          }
        } else if (playMode.value == PlayMode.noRepeat) {
          seek(Duration.zero);
          _player.pause();
        }
      }
    });
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> seek(position) async {
    await _player.seek(position);
  }

  Stream<PlayerState> getPlayerStateStream() {
    return _player.playerStateStream;
  }

  Stream<PlayerPositionData> getPlayerPositionDataStream() {
    return rxdart.Rx.combineLatest3<Duration, Duration, Duration?,
        PlayerPositionData>(
      _player.positionStream,
      _player.bufferedPositionStream,
      _player.durationStream,
      (position, bufferedPosition, duration) => PlayerPositionData(
        position: position,
        bufferedPosition: bufferedPosition,
        duration: duration ?? Duration.zero,
      ),
    );
  }

  void selectRandomSong() {
    if (songs.isNotEmpty) {
      final random = Random();
      final randomSongIndex = random.nextInt(songs.length);
      selectSong(songs[randomSongIndex]);
    }
  }

  void selectNextSong() {
    if (selectedSong.value == null) {
      selectSong(songs.firstOrNull);
      return;
    }

    final selectedSongIndex = songs.indexOf(selectedSong.value);
    if (selectedSongIndex + 1 < songs.length && selectedSongIndex != -1) {
      selectSong(songs[selectedSongIndex + 1]);
    } else {
      selectSong(songs.firstOrNull);
    }
  }

  void selectPreviousSong() {
    if (selectedSong.value == null) {
      selectSong(songs.firstOrNull);
      return;
    }

    final selectedSongIndex = songs.indexOf(selectedSong.value);
    if (selectedSongIndex > 0 && selectedSongIndex != -1) {
      selectSong(songs[selectedSongIndex - 1]);
    } else {
      selectSong(songs.lastOrNull);
    }
  }

  void setPlayMode() {
    if (playMode.value == PlayMode.repeat) {
      playMode.value = PlayMode.single;
    } else if (playMode.value == PlayMode.single) {
      playMode.value = PlayMode.noRepeat;
    } else if (playMode.value == PlayMode.noRepeat) {
      playMode.value = PlayMode.repeat;
    }

    _storage.write(AppConstants.playModeKey, playMode.value.index);
  }

  void setShuffleing() {
    shuffleingOn.value = !shuffleingOn.value;
    _storage.write(AppConstants.shuffleingOnKey, shuffleingOn.value);
  }

  Future<void> getSongs() async {
    isSongsLoading.value = true;
    songs.value = await _onAudioQuery.querySongs();
    isSongsLoading.value = false;
  }

  void search(String songTitle) {
    final regExp = RegExp(songTitle.toLowerCase());
    filteredSongs.value = songs
        .where((song) => regExp.hasMatch(song.title.toLowerCase()))
        .toList();
  }

  void clearFilteredSongs() {
    filteredSongs.clear();
  }
}

enum PlayMode {
  repeat,
  single,
  noRepeat,
}
