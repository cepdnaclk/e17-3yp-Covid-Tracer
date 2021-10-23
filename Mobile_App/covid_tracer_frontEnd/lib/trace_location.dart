import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TraceLocationScreen extends StatefulWidget {
  const TraceLocationScreen({Key? key}) : super(key: key);

  @override
  _TraceLocationScreen createState() => _TraceLocationScreen();
}

class _TraceLocationScreen extends State<TraceLocationScreen> {
  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
    allMarkers.add(const Marker(
        markerId: MarkerId('1'),
        draggable: false,
        position: LatLng(7.0668, 79.9041)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
        ),
        body: Center(
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                    target: LatLng(7.0668, 79.9041), zoom: 12.0),
                markers: Set.from(allMarkers),
              )),
        ));
  }
}
