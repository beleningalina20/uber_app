part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;

  const GpsState(
      {required this.isGpsEnabled, required this.isGpsPermissionGranted});

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];

  @override
  String toString() =>
      '{ isGpsEnabled: $isGpsEnabled, isGpsërmissionGranted: $isGpsPermissionGranted }';

  GpsState copyWith({bool? ige, bool? igpg}) => GpsState(
      isGpsEnabled: ige ?? isGpsEnabled,
      isGpsPermissionGranted: igpg ?? isGpsPermissionGranted);
}
