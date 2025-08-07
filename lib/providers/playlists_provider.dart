import 'package:music_player/providers/audio_query_provider.dart';
import 'package:music_player/providers/my_toast_provider.dart';
import 'package:music_player/utils/app_strings.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playlists_provider.g.dart';

@riverpod
class Playlists extends _$Playlists {
  @override
  FutureOr<List<PlaylistModel>> build() async {
    final audioQuery = ref.watch(audioQueryProvider);
    return await audioQuery.queryPlaylists();
  }

  void createPlaylist(String name) async {
    final audioQuery = ref.read(audioQueryProvider);
    final myToast = ref.read(myToastProvider);
    try {
      final isPlaylistCreated = await audioQuery.createPlaylist(name);
      if (isPlaylistCreated) {
        myToast.showSuccess(AppStrings.playlistCreatedSuccessfully);
        final _ = ref.refresh(playlistsProvider.notifier);
      } else {
        throw Exception();
      }
    } catch (e) {
      myToast.showError(AppStrings.failedToCreatePlaylistTryAgain);
    }
  }

  void deletePlaylist(int playlistId) async {
    final audioQuery = ref.read(audioQueryProvider);
    final myToast = ref.read(myToastProvider);
    try {
      final isPlaylistRemoved = await audioQuery.removePlaylist(playlistId);
      if (isPlaylistRemoved) {
        myToast.showSuccess(AppStrings.playlistCreatedSuccessfully);
        final _ = ref.refresh(playlistsProvider.notifier);
      } else {
        throw Exception();
      }
    } catch (e) {
      myToast.showError(AppStrings.failedToCreatePlaylistTryAgain);
    }
  }
}
