import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/providers/filtered_songs_provider.dart';
import 'package:music_player/utils/app_strings.dart';
import 'package:music_player/widgets/musical_note.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FilteredSongsScreen extends ConsumerWidget {
  const FilteredSongsScreen({
    super.key,
    required this.type,
    required this.where,
  });

  final AudiosFromType type;
  final String where;

  static void navigate({
    required BuildContext context,
    required AudiosFromType type,
    required String where,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilteredSongsScreen(type: type, where: where),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredSongsAsyncValue = ref.watch(
      filteredSongsProvider(type, where),
    );

    final songs = filteredSongsAsyncValue.value ?? [];
    final isLoading = filteredSongsAsyncValue.isLoading;

    final primaryColor = Theme.of(context).primaryColor;

    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: primaryColor));
    }

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.songs)),
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.refresh(filteredSongsProvider(type, where).notifier),
        child: ListView.builder(
          itemCount: songs.length,
          padding: EdgeInsets.symmetric(vertical: 8),
          itemBuilder: (context, index) {
            final song = songs[index];

            return ListTile(
              onTap: () {},
              contentPadding: EdgeInsets.only(left: 16, right: 6),
              leading: QueryArtworkWidget(
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
      ),
    );
  }
}
