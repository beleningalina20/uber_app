import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_app/blocs/blocs.dart';
import 'package:uber_app/helpers/show_loading_message.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const _ManualMarkerBody()
            : const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 115, left: 30, child: _BtnBack()),
          Center(
              child: Transform.translate(
            offset: const Offset(0, -20),
            child: BounceInDown(
                from: 100,
                child: const Icon(Icons.location_on_rounded, size: 60)),
          )),
          // Boton de confirmar
          Positioned(
              bottom: 30,
              left: 30,
              child: FadeInUp(
                duration: const Duration(milliseconds: 300),
                child: MaterialButton(
                    minWidth: size.width - 120,
                    onPressed: () async {
                      final start = locationBloc.state.lastKnownLocation;
                      if (start == null) return;
                      final end = mapBloc.mapCenter;
                      if (end == null) return;

                      /*showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                              title: const Text('Espere por favor'),
                              content: Container(
                                width: 100,
                                height: 100,
                                margin: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: const [
                                    Text('Calculando ruta'),
                                    SizedBox(height: 5),
                                    CircularProgressIndicator()
                                  ],
                                ),
                              )));*/

                      searchBloc.add(OnDeactivateManualMarkerEvent());
                      final destination =
                          await searchBloc.getCoorsStartToEnd(start, end);
                      await mapBloc.drawRoutePolyline(destination);

                      searchBloc.add(OnDeactivateManualMarkerEvent());

                      // Navigator.pop(context);
                    },
                    color: Colors.black,
                    elevation: 0,
                    height: 50,
                    shape: const StadiumBorder(),
                    child: const Text('Confirmar destino',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300))),
              )),
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: IconButton(
            onPressed: () {
              print('Deactive manual marker');
              BlocProvider.of<SearchBloc>(context)
                  .add(OnDeactivateManualMarkerEvent());
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
    );
  }
}
