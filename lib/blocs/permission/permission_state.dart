part of 'permission_bloc.dart';

class PermissionState extends Equatable {
  const PermissionState({this.isLoading = false, required this.hasPermission});

  final bool isLoading;
  final bool hasPermission;

  @override
  List<Object> get props => [isLoading, hasPermission];

  PermissionState copyWith({bool? isLoading, bool? hasPermission}) {
    return PermissionState(
      isLoading: isLoading ?? this.isLoading,
      hasPermission: hasPermission ?? this.hasPermission,
    );
  }
}
