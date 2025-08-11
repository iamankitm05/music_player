import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/providers/artists_provider.dart';
import 'package:music_player/utils/app_strings.dart';
import 'package:music_player/widgets/musical_note.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistsTabView extends ConsumerWidget {
  const ArtistsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artistsAsyncValue = ref.watch(artistsProvider);

    final artists = artistsAsyncValue.value ?? [];
    final isLoading = artistsAsyncValue.isLoading;

    final primaryColor = Theme.of(context).primaryColor;

    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: primaryColor));
    }

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(artistsProvider.notifier),
      child: ListView.builder(
        itemCount: artists.length,
        padding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final artist = artists[index];

          return ListTile(
            onTap: () {},
            leading: QueryArtworkWidget(
              id: artist.id,
              type: ArtworkType.ARTIST,
              nullArtworkWidget: MusicalNote(),
            ),
            title: Text(artist.artist),
            subtitle: Text(
              AppStrings.xAlbumYTracks(
                artist.numberOfAlbums ?? 0,
                artist.numberOfTracks ?? 0,
              ),
            ),
          );
        },
      ),
    );
  }
}
