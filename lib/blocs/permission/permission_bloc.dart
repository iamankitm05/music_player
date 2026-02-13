import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/services/permission_service.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc({
    required bool hasPermission,
    required PermissionService permissionsService,
  }) : _permissionsService = permissionsService,
       super(PermissionState(hasPermission: hasPermission)) {
    on<RequestPermission>(_requestPermission);
  }

  final PermissionService _permissionsService;

  FutureOr<void> _requestPermission(
    RequestPermission event,
    Emitter<PermissionState> emit,
  ) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    final hasPermission = await _permissionsService.requestPermission();
    emit(state.copyWith(hasPermission: hasPermission, isLoading: false));
  }
}
