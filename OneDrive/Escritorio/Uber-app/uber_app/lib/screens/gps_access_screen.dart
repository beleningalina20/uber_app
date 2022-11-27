import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_app/blocs/gps/gps_bloc.dart';

class GPSAccessScreen extends StatelessWidget {
  const GPSAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        print('!state.isGpsEnabled -> ${!state.isGpsEnabled}');
        return (!state.isGpsEnabled) ? _EnableGPSMessage() : _AccessButton();
      },
    );
  }
}

class _EnableGPSMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Debe habilitar el GPS',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300));
  }
}

class _AccessButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es necesario el acceso al GPS',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
        MaterialButton(
            shape: const StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            color: Colors.black,
            onPressed: () {
              final gpsBloc = BlocProvider.of<GpsBloc>(context, listen: false);
              // final gpsBloc = context.read<GpsBloc>();
              gpsBloc.askGpsAccess();
            },
            child: const Text('Solicitar acceso',
                style: TextStyle(color: Colors.white)))
      ],
    );
  }
}
