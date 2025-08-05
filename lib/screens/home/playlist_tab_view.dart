import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistTabView extends ConsumerWidget {
  const PlaylistTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text('Playlist'));
  }
}
