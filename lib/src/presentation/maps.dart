import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  final String placename;
  final double latitude;
  final double longitude;
  const MapScreen({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.placename,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: {
          Marker(
            markerId: MarkerId(widget.placename),
            position: LatLng(widget.latitude, widget.longitude),
          ),
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
