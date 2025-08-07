import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/providers/albums_provider.dart';
import 'package:music_player/widgets/musical_note.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumsTabView extends ConsumerWidget {
  const AlbumsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsyncValue = ref.watch(albumsProvider);

    final albums = albumsAsyncValue.value ?? [];
    final isLoading = albumsAsyncValue.isLoading;

    final primaryColor = Theme.of(context).primaryColor;

    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: primaryColor));
    }

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(albumsProvider.notifier),
      child: ListView.builder(
        itemCount: albums.length,
        padding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final album = albums[index];

          return ListTile(
            onTap: () {},
            leading: QueryArtworkWidget(
              id: album.id,
              type: ArtworkType.ALBUM,
              nullArtworkWidget: MusicalNote(),
            ),
            title: Text(album.album),
            subtitle: Text('${album.numOfSongs} Songs'),
          );
        },
      ),
    );
  }
}
