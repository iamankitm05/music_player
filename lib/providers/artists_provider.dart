import 'package:music_player/providers/audio_query_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artists_provider.g.dart';

@riverpod
class Artists extends _$Artists {
  @override
  FutureOr<List<ArtistModel>> build() async {
    final audioQuery = ref.watch(audioQueryProvider);
    return await audioQuery.queryArtists();
  }
}
