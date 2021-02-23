import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourtracking/main.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  @override
  void initState(){
    crearmarcadores();
    super.initState();
  }

  crearmarcadores(){
    _database.collectionGroup('trip_list${prefs.getString("uid")}').snapshots().listen((snapshot) {

      if(snapshot.docs.isNotEmpty){
        for(int i = 0; i<snapshot.docs.length; i++){
       //   initMarker(snapshot.docs[i].data, snapshot.docs[i]["title"]);
          print("map data lat: ${snapshot.docs[i]["lat"]} lon:${snapshot.docs[i]["long"]} ");
        }

      }
    });
  }

  //     .then((docs) {
  // if(docs.docs.){
  // for(int i= 0; i < docs.documents.length; i++) {
  // initMarker(docs.documents[i].data, docs.documents[i].documentID);
  // }
  // }
  // });
  //
  void initMarker(lugar, lugaresid) {
    var markerIdVal = lugaresid;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lugar['Latitud'], lugar['Longitud']),
      infoWindow: InfoWindow(title: lugar['Lugar'], snippet: lugar['tipo']),
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers.values),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _currentLocation,
      //   label: Text('Ir a mi Ubicacion!'),
      //   icon: Icon(Icons.location_on),
      // ),
    );
  }



  // void _currentLocation() async {
  //   final GoogleMapController controller = await _controller.future;
  //   LocationData currentLocation;
  //   var location = new Location();
  //   try {
  //     currentLocation = await location.getLocation();
  //   } on Exception {
  //     currentLocation = null;
  //   }
  //
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //     CameraPosition(
  //       bearing: 0,
  //       target: LatLng(currentLocation.latitude, currentLocation.longitude),
  //       zoom: 17.0,
  //     ),
  //   ));
  // }

}
