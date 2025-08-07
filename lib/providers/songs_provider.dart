import 'package:music_player/providers/audio_query_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'songs_provider.g.dart';

@riverpod
class Songs extends _$Songs {
  @override
  FutureOr<List<SongModel>> build() async {
    final audioQuery = ref.watch(audioQueryProvider);
    return await audioQuery.querySongs();
  }
}
