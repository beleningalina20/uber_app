part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitial;
  final bool isFollowingUser;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  final bool showMyRoute;

  const MapState({
    this.isMapInitial = false,
    this.isFollowingUser = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    this.showMyRoute = true,
  })  : polylines = polylines ?? const {},
        markers = markers ?? const {};

  // Si no me viene las polylines, se inicializa con un objeto vacio

  MapState copyWith(
          {bool? imi,
          bool? fu,
          Map<String, Polyline>? p,
          bool? smr,
          Map<String, Marker>? m}) =>
      MapState(
          isMapInitial: imi ?? isMapInitial,
          isFollowingUser: fu ?? isFollowingUser,
          polylines: p ?? polylines,
          showMyRoute: smr ?? showMyRoute,
          markers: m ?? markers);

  @override
  List<Object> get props =>
      [isMapInitial, isFollowingUser, polylines, showMyRoute, markers];
}
