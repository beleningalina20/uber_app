part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnownLocation;
  final List<LatLng> myLocationHistory;

  const LocationState(
      {this.followingUser = true, this.lastKnownLocation, myLocationHistory})
      : myLocationHistory = myLocationHistory ?? const [];

  LocationState copyWith({bool? fu, LatLng? lkl, List<LatLng>? mlh}) =>
      LocationState(
          followingUser: fu ?? followingUser,
          lastKnownLocation: lkl ?? lastKnownLocation,
          myLocationHistory: mlh ?? myLocationHistory);

  @override
  List<Object?> get props =>
      [followingUser, lastKnownLocation, myLocationHistory];
}

class LocationInitial extends LocationState {}
