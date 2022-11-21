import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TraceLocationScreen extends StatefulWidget {
  const TraceLocationScreen({Key? key}) : super(key: key);

  @override
  _TraceLocationScreen createState() => _TraceLocationScreen();
}

class _TraceLocationScreen extends State<TraceLocationScreen> {
  late GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = {}; //markers for google map
  static const LatLng showLocation = LatLng(7.0599, 79.8956);

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
                  target: showLocation, //initial position
                  zoom: 13.0,
                ),
                //markers: Set.from(allMarkers),
                markers: getmarkers(),
                mapType: MapType.normal, //map type
                onMapCreated: (controller) {
                  //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
              )),
        ));
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Visited',
          snippet: 'Infected 4%',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add second marker
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(
            7.103111806402098, 79.91024373067867), //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Visited',
          snippet: 'Infected 7%',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId(showLocation.toString()),
        position: const LatLng(
            7.087993298170049, 79.89776456932132), //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Visited',
          snippet: 'Infected 5%',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}
