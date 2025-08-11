import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/providers/songs_provider.dart';
import 'package:music_player/widgets/musical_note.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  static void navigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen()),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final songsAsyncValue = ref.watch(songsProvider);

    final songs =
        songsAsyncValue.value?.where((song) {
          return song.title.toLowerCase().contains(
            searchQuery.text.toLowerCase(),
          );
        }).toList() ??
        [];
    final isLoading = songsAsyncValue.isLoading;

    final primaryColor = Theme.of(context).primaryColor;

    if (isLoading) {
      return Center(child: CircularProgressIndicator(color: primaryColor));
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: searchQuery,
          decoration: InputDecoration(hintText: 'Search'),
        ),
      ),
      body: ListView.builder(
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
    );
  }

  final searchQuery = TextEditingController();

  @override
  void dispose() {
    searchQuery.dispose();
    super.dispose();
  }
}
