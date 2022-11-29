import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_app/blocs/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;

  const MapView(
      {super.key, required this.initialLocation, required this.polylines});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 14.4746,
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Listener(
        onPointerMove: (event) {
          mapBloc.add(OnStopFollowingUserEvent());
        },
        child: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: initialCameraPosition,
            compassEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: (controller) {
              mapBloc.add(OnMapInitializeEvent(controller));
            },
            polylines: polylines
            // TODO Markers
            // TODO polylines
            // TODO Cuando se mueve el mapa
            ),
      ),
    );
  }
}
