import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/providers/playlists_provider.dart';
import 'package:music_player/utils/app_strings.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistFormDialog extends ConsumerStatefulWidget {
  const PlaylistFormDialog({super.key, this.playlist});

  final PlaylistModel? playlist;

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
        title: Text(
          widget.playlist == null
              ? AppStrings.createPlaylist
              : AppStrings.renamePlaylist,
        ),
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
          ElevatedButton(
            onPressed: _onCreate,
            child: Text(
              widget.playlist == null ? AppStrings.create : AppStrings.rename,
            ),
          ),
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
    if (!(form.currentState?.validate() ?? false)) return;

    if (widget.playlist == null) {
      ref
          .read(playlistsProvider.notifier)
          .createPlaylist(playlistName.text.trim());
    } else {
      ref
          .read(playlistsProvider.notifier)
          .renamePlaylist(widget.playlist!.id, playlistName.text.trim());
    }
    Navigator.pop(context);
  }
}
