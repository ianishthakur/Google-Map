// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rxdart/rxdart.dart';
// import 'dart:async';
import "package:location/location.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Google Map',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: FireMap(),
        ));
  }
}

class FireMap extends StatefulWidget {
  const FireMap({
    Key? key,
  }) : super(key: key);

  @override
  State<FireMap> createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  late GoogleMapController mapController;
  Location location = new Location();
  build(context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(27.7172, 85.3240), zoom: 15),
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.hybrid,
          compassEnabled: true,
          markers: _addMarker(),

          // gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          //           new Factory<OneSequenceGestureRecognizer>(
          //             () => new EagerGestureRecognizer(),
          //           ),
          //         ].toSet(),
        ),
        Positioned(
            bottom: 100,
            right: 10,
            child: ElevatedButton(
              onPressed: _addMarker,
              child: Icon(
                Icons.pin_drop,
                color: Colors.red,
              ),
            ))
      ],
    );
  }

//   mapController.animateCamera(
//   CameraUpdate.newCameraPosition(
//     CameraPosition(
//       target: LatLng(
//         // Will be fetching in the next step
//         _currentPosition.latitude,
//         _currentPosition.longitude,
//       ),
//       zoom: 18.0,
//     ),
//   ),
// );
  Location? _location;
  final Set<Marker> markers = new Set();
  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      _location!.onLocationChanged.listen((l) {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 20),
          ),
        );
      });
    });
  }

  _addMarker() {
    setState(() {
      markers.add(const Marker(
        //add third marker
        markerId: MarkerId("outletinfoMarker"
            // _center.toString()
            ),
        position: LatLng(27.7172, 85.3240),
        //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: "Hello",
          snippet: "Hey",
        ),
        icon: BitmapDescriptor.defaultMarker,
        //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}

  // _animateToUser() async {
  //   var pos = await location.getLocation();
  //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(pos['latitude'], pos['longitude']),
  //     zoom: 17.0
  //   )));
  // }
