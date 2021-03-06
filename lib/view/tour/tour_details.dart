import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourtracking/style/style.dart';
import 'package:tourtracking/widget/custom_appbar.dart';

class TourDetails extends StatefulWidget {
  String markerId, imageUrl, title, desc, startTime, endTime, location;
  double lat, lon;

  TourDetails({
    @required this.markerId,
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.startTime,
    @required this.endTime,
    @required this.location,
    @required this.lat,
    @required this.lon,
  });

  @override
  _TourDetailsState createState() => _TourDetailsState();
}

class _TourDetailsState extends State<TourDetails> {
  List<Marker> allMarkers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    allMarkers.add(Marker(
        markerId: MarkerId('${widget.markerId}'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(widget.lat, widget.lon)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppbar(title: "Tour Details"),
      ),
      body: Column(
        children: [
          SizedBox(height: Get.height * .04),
          Hero(
            tag: "${widget.markerId}",
            child: CircleAvatar(
              radius: Get.height * .083,
              backgroundColor: Style.primaryColor,
              child: CircleAvatar(
                radius: Get.height * .08,
                backgroundImage: NetworkImage(
                  "${widget.imageUrl}",
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            padding: EdgeInsets.all(15),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [Style.boxShadow],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "${widget.title}",
                      style: TextStyle(color: Style.primaryTextColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * .01),
                Row(
                  children: [
                    Text(
                      "${widget.location}",
                      style: TextStyle(color: Style.primaryTextColor, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * .02),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${widget.desc}",
                        style: TextStyle(color: Style.primaryTextColor, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${widget.startTime} to ${widget.endTime}",
                      style: TextStyle(color: Style.primaryTextColor, fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            padding: EdgeInsets.all(15),
            width: Get.width,
            height: Get.height * .3,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [Style.boxShadow],
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: Get.width,
              height: Get.height * .3,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(target: LatLng(widget.lat, widget.lon), zoom: 13),
                myLocationEnabled: true,
                markers: Set.from(allMarkers),
              ),
            ),
          )
        ],
      ),
    );
  }
}
