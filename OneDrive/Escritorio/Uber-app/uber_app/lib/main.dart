import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_app/blocs/gps/gps_bloc.dart';
import 'package:uber_app/screens/screens.dart';

void main() => runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (_) => GpsBloc())],
    child: const MapsApp()));

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
