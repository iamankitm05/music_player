part of 'songs_bloc.dart';

sealed class SongsState extends Equatable {
  const SongsState();

  @override
  List<Object> get props => [];
}

final class SongsPermissionDenied extends SongsState {}

final class SongsLoading extends SongsState {}

final class SongsSuccess extends SongsState {}

final class SongsFailure extends SongsState {
  final String error;

  const SongsFailure(this.error);
}
