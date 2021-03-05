import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tourtracking/main.dart';
import 'dart:async';
import 'package:tourtracking/utils/appConstant.dart';
import 'package:tourtracking/widget/customLoader.dart';
import 'package:tourtracking/widget/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    markerData();
    super.initState();
  }

  markerData() {
    _database.collectionGroup('trip_list${prefs.getString("uid")}').snapshots().listen((snapshot) {

      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          //   initMarker(snapshot.docs[i].data, snapshot.docs[i]["title"]);
          print("map data lat: ${snapshot.docs[i]["lat"]} lon:${snapshot.docs[i]["long"]} ");
          initMarker(
              lat: double.parse("${snapshot.docs[i]["lat"]}"),
              lng: double.parse("${snapshot.docs[i]["long"]}"),
              title: "${snapshot.docs[i]["title"]}",
              id: "${snapshot.docs[i]["title"]}");
        }
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  void initMarker({@required double lat, @required double lng, @required String id, @required String title}) {
    var markerIdVal = id;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title, snippet: "tipo"),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(target: LatLng(23.990459, 90.210615), zoom: 6.8);

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: CustomLoader(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: CustomAppbar(title:"Tour Map"),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationEnabled: true,
          markers: Set<Marker>.of(markers.values),
        ),
      ),
    );
  }
}
