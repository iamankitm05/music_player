import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/models/track_model.dart';
import 'package:music_player/services/permission_service.dart';

part 'tracks_event.dart';
part 'tracks_state.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState> {
  TracksBloc() : super(TracksState()) {
    on<RefreshTracks>(_refreshTracks);
  }

  FutureOr<void> _refreshTracks(
    RefreshTracks event,
    Emitter<TracksState> emit,
  ) async {}
}
