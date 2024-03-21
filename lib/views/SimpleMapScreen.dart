import 'package:flutter/material.dart';
import 'dart:async'; // Import dart:async
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMapScreen extends StatefulWidget {
  @override
  _SimpleMapScreenState createState() => _SimpleMapScreenState();
}

class _SimpleMapScreenState extends State<SimpleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(56.130366, -106.346770),
    zoom: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Map')),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(
              controller); // Complete the Completer with the controller
        },
      ),
    );
  }
}
