import 'package:music_player/providers/audio_query_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permissions_provider.g.dart';

@Riverpod(keepAlive: true)
class Permissions extends _$Permissions {
  @override
  FutureOr<bool> build() async {
    final audioQuery = ref.watch(audioQueryProvider);
    return await audioQuery.permissionsStatus();
  }

  void requestPermissions() async {
    if (state.isLoading) return;
    final audioQuery = ref.read(audioQueryProvider);
    state = AsyncLoading();
    final hasPermission = await audioQuery.permissionsRequest();
    state = AsyncData(hasPermission);
  }
}
