import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/providers/playlists_provider.dart';
import 'package:music_player/theme/app_colors.dart';
import 'package:music_player/utils/app_strings.dart';
import 'package:music_player/widgets/confirmation_dialog.dart';
import 'package:music_player/widgets/musical_note.dart';
import 'package:music_player/widgets/playlist_form_dialog.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistTile extends ConsumerWidget {
  const PlaylistTile(this.playlist, {super.key});

  final PlaylistModel playlist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.only(left: 16, right: 2),
      leading: QueryArtworkWidget(
        id: playlist.id,
        type: ArtworkType.PLAYLIST,
        nullArtworkWidget: MusicalNote(),
      ),
      title: Text(playlist.playlist),
      subtitle: Text(AppStrings.nSongs(playlist.numOfSongs)),
      trailing: PopupMenuButton(
        itemBuilder: (context) => _itemBuilder(context, playlist, ref),
      ),
    );
  }

  List<PopupMenuEntry> _itemBuilder(
    BuildContext context,
    PlaylistModel playlist,
    WidgetRef ref,
  ) {
    return [
      PopupMenuItem(
        onTap: () => _onRenameTap(context),
        child: Text(AppStrings.rename),
      ),
      PopupMenuItem(
        onTap: () => _onDeleteTap(context, ref),
        child: Text(AppStrings.delete),
      ),
    ];
  }

  void _onRenameTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return PlaylistFormDialog(playlist: playlist);
      },
    );
  }

  void _onDeleteTap(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: AppStrings.delete,
          message: AppStrings.deletingThisCannotBeUndonePleaseConfirmToProceed,
          okBtnColor: AppColors.red,
          okBtnLabel: AppStrings.delete,
          onConfirm: () {
            ref.read(playlistsProvider.notifier).removePlaylist(playlist.id);
          },
        );
      },
    );
  }
}
