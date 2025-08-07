import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/providers/playlists_provider.dart';
import 'package:music_player/utils/app_strings.dart';
import 'package:music_player/widgets/musical_note.dart';
import 'package:music_player/widgets/playlist_form_dialog.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistTabView extends ConsumerWidget {
  const PlaylistTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsyncValue = ref.watch(playlistsProvider);

    final playlists = playlistsAsyncValue.value ?? [];
    final isLoading = playlistsAsyncValue.isLoading;

    final primaryColor = Theme.of(context).primaryColor;

    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: primaryColor));
    }

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(playlistsProvider.notifier),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return PlaylistFormDialog();
                  },
                );
              },
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              leading: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add),
              ),
              title: Text(AppStrings.createPlaylist),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8),
            sliver: SliverList.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];

                return ListTile(
                  onTap: () {},
                  leading: QueryArtworkWidget(
                    id: playlist.id,
                    type: ArtworkType.PLAYLIST,
                    nullArtworkWidget: MusicalNote(),
                  ),
                  title: Text(playlist.playlist),
                  subtitle: Text('${playlist.numOfSongs} Songs'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
