import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/providers/songs_provider.dart';
import 'package:music_player/widgets/musical_note.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsTabView extends ConsumerWidget {
  const AllSongsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsAsyncValue = ref.watch(songsProvider);

    final songs = songsAsyncValue.value ?? [];
    final isLoading = songsAsyncValue.isLoading;

    final primaryColor = Theme.of(context).primaryColor;

    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: primaryColor));
    }

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(songsProvider.notifier),
      child: ListView.builder(
        itemCount: songs.length,
        padding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final song = songs[index];

          return ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.only(left: 16, right: 6),
            leading: QueryArtworkWidget(
              // controller: _audioQuery,
              id: song.id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: MusicalNote(),
            ),
            title: Text(song.displayName),
            subtitle: Text(song.artist ?? ''),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.pause)),
          );
        },
      ),
    );
  }
}
