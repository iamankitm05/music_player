import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:music_player/blocs/permission/permission_bloc.dart';
import 'package:music_player/services/permission_service.dart';
import 'package:music_player/utils/app_bloc_observer.dart';

final getIt = GetIt.instance;

abstract final class DiInjector {
  static Future<void> init() async {
    Bloc.observer = AppBlocObserver();

    // Register services
    getIt.registerFactory(() => PermissionService());

    final permissionsService = getIt<PermissionService>();
    final hasStoragePermission = await permissionsService.checkPermission();

    // Register blocs
    getIt.registerSingleton(
      PermissionBloc(
        hasPermission: hasStoragePermission,
        permissionsService: permissionsService,
      ),
    );
  }
}
