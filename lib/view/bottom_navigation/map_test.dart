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
    markerData();
    super.initState();
  }

  markerData(){
    _database.collectionGroup('trip_list${prefs.getString("uid")}').snapshots().listen((snapshot) {

      if(snapshot.docs.isNotEmpty){
        for(int i = 0; i<snapshot.docs.length; i++){
       //   initMarker(snapshot.docs[i].data, snapshot.docs[i]["title"]);
          print("map data lat: ${snapshot.docs[i]["lat"]} lon:${snapshot.docs[i]["long"]} ");
          initMarker(lat:double.parse("${snapshot.docs[i]["lat"]}"), lng: double.parse("${snapshot.docs[i]["long"]}"),title: "${snapshot.docs[i]["title"]}",id: "${snapshot.docs[i]["title"]}" );
        }

      }
    });
  }

  void initMarker({@required double lat,@required  double lng,@required  String id,@required  String title}) {
    var markerIdVal = id;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title, snippet: "tipo"),
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(target: LatLng(24.4804796, 89.9678135), zoom: 7.1);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }




}
