import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/providers/playlists_provider.dart';
import 'package:music_player/utils/app_strings.dart';

class PlaylistFormDialog extends ConsumerStatefulWidget {
  const PlaylistFormDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaylistFormDialogState();
}

class _PlaylistFormDialogState extends ConsumerState<PlaylistFormDialog> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: AlertDialog(
        insetPadding: EdgeInsets.all(16),
        title: Text(AppStrings.createPlaylist),
        content: SizedBox(
          width: 500,
          child: TextFormField(
            controller: playlistName,
            decoration: InputDecoration(hintText: AppStrings.enterPlaylistName),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.pleaseEnterAValidPlaylistName;
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.cancel),
          ),
          ElevatedButton(onPressed: _onCreate, child: Text(AppStrings.create)),
        ],
      ),
    );
  }

  final form = GlobalKey<FormState>();
  final playlistName = TextEditingController();

  @override
  void dispose() {
    playlistName.dispose();
    super.dispose();
  }

  void _onCreate() {
    ref
        .read(playlistsProvider.notifier)
        .createPlaylist(playlistName.text.trim());
    Navigator.pop(context);
  }
}
