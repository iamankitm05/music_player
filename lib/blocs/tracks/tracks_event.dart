part of 'tracks_bloc.dart';

sealed class TracksEvent extends Equatable {
  const TracksEvent();

  @override
  List<Object> get props => [];
}

final class RefreshTracks extends TracksEvent {}

final class GetTracks extends TracksEvent {}
