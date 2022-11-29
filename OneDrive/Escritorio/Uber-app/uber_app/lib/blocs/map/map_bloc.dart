import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_app/blocs/blocs.dart';
import 'package:uber_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? _mapController;
  final LocationBloc locationBloc;
  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializeEvent>(_onInitMap);

    on<OnStartFollowingUserEvent>(_onStartFollowingUser);
    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(fu: false)));

    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<OnToggleUserRouteEvent>(
      (event, emit) => emit(state.copyWith(smr: !state.showMyRoute)),
    );

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }

      if (!state.isFollowingUser) return;
      if (locationState.lastKnownLocation == null) return;
      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitializeEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    emit(state.copyWith(imi: true));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(fu: true));
    if (locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  FutureOr<void> _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocations);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(p: currentPolylines));
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
