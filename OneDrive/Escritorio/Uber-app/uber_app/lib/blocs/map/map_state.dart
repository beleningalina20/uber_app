part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitial;
  final bool isFollowingUser;
  final Map<String, Polyline> polylines;
  final bool showMyRoute;

  const MapState({
    this.isMapInitial = false,
    this.isFollowingUser = true,
    Map<String, Polyline>? polylines,
    this.showMyRoute = true,
  }) : polylines = polylines ??
            const {}; // Si no me viene las polylines, se inicializa con un objeto vacio

  MapState copyWith(
          {bool? imi, bool? fu, Map<String, Polyline>? p, bool? smr}) =>
      MapState(
          isMapInitial: imi ?? isMapInitial,
          isFollowingUser: fu ?? isFollowingUser,
          polylines: p ?? polylines,
          showMyRoute: smr ?? showMyRoute);

  @override
  List<Object> get props =>
      [isMapInitial, isFollowingUser, polylines, showMyRoute];
}
