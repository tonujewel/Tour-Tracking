import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:tourtracking/utils/appConstant.dart';

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            successSnackbar("clicked");
          },
          child: Icon(Icons.add),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: LatLng(23.7985053, 90.3842538), zoom: 13),
          onMapCreated: _onMapCreated,
          markers: Set.from(markers),
        ),
      ),
    );
  }
}
