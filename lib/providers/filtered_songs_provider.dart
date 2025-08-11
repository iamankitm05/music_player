import 'package:music_player/providers/audio_query_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_songs_provider.g.dart';

@riverpod
class FilteredSongs extends _$FilteredSongs {
  @override
  FutureOr<List<SongModel>> build(AudiosFromType type, String where) async {
    final audioQuery = ref.read(audioQueryProvider);
    return await audioQuery.queryAudiosFrom(type, where);
  }
}
