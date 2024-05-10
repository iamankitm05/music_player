import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerController extends GetxController {
  final _onAudioQuery = OnAudioQuery();

  final permissionsStatus = false.obs;

  Future<void> init() async {
    await getPermissionsStatus();
  }

  Future<bool> getPermissionsStatus() async {
    permissionsStatus.value = await _onAudioQuery.permissionsStatus();
    return permissionsStatus.value;
  }

  Future<bool> permissionsRequest() async {
    permissionsStatus.value = await _onAudioQuery.permissionsRequest();
    return permissionsStatus.value;
  }

  /*
   * Song Player
   */
  final selectedSong = Rxn<SongModel>();
  final shuffleingOn = false.obs;
  final Rx<PlayMode> playMode = PlayMode.repeat.obs;

  void selectSong(SongModel song) {
    selectedSong.value = song;
  }

  void selectNextSong(SongModel song) {
    selectedSong.value = song;
  }

  void selectPreviousSong(SongModel song) {
    selectedSong.value = song;
  }

  void setPlayMode() {
    if (playMode.value == PlayMode.repeat) {
      playMode.value = PlayMode.single;
    } else if (playMode.value == PlayMode.single) {
      playMode.value = PlayMode.noRepeat;
    } else if (playMode.value == PlayMode.noRepeat) {
      playMode.value = PlayMode.repeat;
    }
  }

  void setShuffleing() {
    shuffleingOn.value = !shuffleingOn.value;
  }

  /*
   * Songs Listing 
   */
  final isSongsLoading = false.obs;
  final songs = <SongModel>[].obs;

  Future<void> getSongs() async {
    isSongsLoading.value = true;
    songs.value = await _onAudioQuery.querySongs();
    isSongsLoading.value = false;
  }

  final filteredSongs = [].obs;

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
