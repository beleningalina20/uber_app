import 'package:flutter/material.dart';
import 'package:uber_app/marker/markers.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
              width: 350,
              height: 150,
              child: CustomPaint(
                painter:
                    EndMarkerPainter(destination: 'mi casa', kilometers: 15),
              ))),
    );
  }
}
