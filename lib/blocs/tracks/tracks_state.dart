part of 'tracks_bloc.dart';

class TracksState extends Equatable {
  const TracksState({
    this.hasLoading = false,
    this.hasLoadingMore = false,
    this.hasPermission = false,
    this.error,
    this.success,
    this.tracks = const [],
  });

  final bool hasLoading;
  final bool hasLoadingMore;
  final String? error;
  final String? success;
  final bool hasPermission;
  final List<TrackModel> tracks;

  @override
  List<Object?> get props => [
    hasLoading,
    hasLoadingMore,
    hasPermission,
    error,
    success,
    tracks.hashCode,
  ];

  TracksState copyWith({
    bool? hasLoading,
    bool? hasLoadingMore,
    bool? hasPermission,
    String? error,
    String? success,
    List<TrackModel>? tracks,
  }) {
    return TracksState(
      hasLoading: hasLoading ?? this.hasLoading,
      hasLoadingMore: hasLoadingMore ?? this.hasLoadingMore,
      hasPermission: hasPermission ?? this.hasPermission,
      tracks: tracks ?? this.tracks,
      error: error,
      success: success,
    );
  }
}
