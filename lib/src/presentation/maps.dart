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
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            title: const Text('Maps',
                style: TextStyle(
                  color: Colors.white,
                )),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GoogleMap(
            mapType: MapType.normal,
            markers: {
              Marker(
                markerId: MarkerId(widget.placename),
                position: LatLng(widget.latitude, widget.longitude),
                infoWindow: InfoWindow(
                  title: widget.placename,
                ),
              ),
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(1.5318480528729033, 32.322001370741745),
              zoom: 6.6,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ));
  }
}
//1.5318480528729033, 32.322001370741745 Uganda coordinates