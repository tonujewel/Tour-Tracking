import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourtracking/main.dart';
import 'dart:async';
import 'package:tourtracking/utils/appConstant.dart';
import 'package:tourtracking/view/trip/add_trip.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];

  Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
    return Marker(
        markerId: MarkerId(AppConstant.list[index]['id']),
        position: LatLng(
          AppConstant.list[index]['lat'],
          AppConstant.list[index]['lon'],
        ),
        infoWindow: InfoWindow(title: AppConstant.list[index]["title"]));
  });

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // mapController.setMapStyle('[{"featureType": "all","stylers": [{ "color": "#C0C0C0" }]},{"featureType": "road.arterial","elementType": "geometry","stylers": [{ "color": "#CCFFFF" }]},{"featureType": "landscape","elementType": "labels","stylers": [{ "visibility": "off" }]}]');
  }


  void queryValues() {
    FirebaseFirestore.instance.collectionGroup('trip_list${prefs.getString("uid")}').snapshots().listen((snapshot) {
      double tempTotal = snapshot.docs.fold(0, (tot, doc) => tot + double.parse(doc['item_price']));

     // AsyncSnapshot<QuerySnapshot> snapshot = snapshot.docs.map((e) => );
      setState(() {
     //   totalAmount = tempTotal;
      });
    });
  }

  @override
  void initState() {
    setState(() {
      print("called");
      markers = _markers;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(target: LatLng(23.7985053, 90.3842538), zoom: 13),
          onMapCreated: _onMapCreated,
          markers: Set.from(markers),
        ),
      ),
    );
  }
}
