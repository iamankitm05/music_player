import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/blocs/permission/permission_bloc.dart';
import 'package:music_player/screens/tracks_view.dart';
import 'package:music_player/utils/di_injector.dart';
import 'package:music_player/widgets/permission_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionBloc = getIt<PermissionBloc>();

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Music Player')),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            ColoredBox(
              color: colorScheme.primary,
              child: TabBar(
                labelColor: colorScheme.onPrimary,
                unselectedLabelStyle: textTheme.bodyMedium,
                unselectedLabelColor: colorScheme.secondary,
                labelStyle: textTheme.labelLarge,
                indicatorColor: colorScheme.onPrimary,
                tabs: [
                  Tab(text: 'Tracks'),
                  Tab(text: 'Playlist'),
                  Tab(text: 'Albums'),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<PermissionBloc, PermissionState>(
                bloc: permissionBloc,
                builder: (context, state) {
                  if (state.hasPermission) {
                    return TabBarView(
                      children: [TracksView(), TracksView(), TracksView()],
                    );
                  }

                  return PermissionDialog(
                    onPermissionTap: () {
                      permissionBloc.add(RequestPermission());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
