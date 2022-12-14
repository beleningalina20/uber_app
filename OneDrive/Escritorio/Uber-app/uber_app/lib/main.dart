import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_app/blocs/blocs.dart';
import 'package:uber_app/screens/screens.dart';
import 'package:uber_app/services/services.dart';

void main() => runApp(MultiBlocProvider(providers: [
      BlocProvider(create: (_) => GpsBloc()),
      BlocProvider(create: (_) => LocationBloc()),
      // Injeccion de dependencias
      BlocProvider(
          create: (context) =>
              MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),

      BlocProvider(create: (_) => SearchBloc(trafficService: TrafficService()))
    ], child: const MapsApp()));

// Ctrl + F2
class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      home: LoadingScreen(),
    );
  }
}
