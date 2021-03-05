import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tourtracking/controller/search_controller.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/widget/app_with_back.dart';
import 'package:tourtracking/widget/customLoader.dart';
import 'package:tourtracking/widget/customTextField.dart';
import 'add_trip.dart';

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  var searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => ModalProgressHUD(
        progressIndicator: CustomLoader(),
        inAsyncCall: searchController.isLoading.value,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: CustomAppbarBack(title: "Add Location"),
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0, top: 12.0, bottom: 12.0, right: 10.0),
                    child: Container(
                        width: mainWidth * .8,
                        child: CustomTextField(controller: searchController.searchTextController, hints: 'Search')),
                  ),
                  GestureDetector(
                    onTap: () {
                      searchController.searchAction();
                    },
                    child: Container(
                        width: size.width * .12,
                        height: size.height * .062,
                        //padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFE3E8F0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(Icons.search)),
                  ),
                ],
              ),
              Obx(
                () => Expanded(
                  child: searchController.searchResultDm.value.info == null
                      ? SizedBox()
                      : ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: searchController.searchResultDm.value.results.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                onTap: () {
                                  Get.off(AddTrip(
                                    name:
                                        "${searchController.searchResultDm.value.results[index].locations[index].adminArea5},"
                                        "${searchController.searchResultDm.value.results[index].locations[index].adminArea3},"
                                        "${searchController.searchResultDm.value.results[index].locations[index].adminArea1}",
                                    lat:
                                        "${searchController.searchResultDm.value.results[index].locations[index].latLng.lat}",
                                    long:
                                        "${searchController.searchResultDm.value.results[index].locations[index].latLng.lng}",
                                  ));
                                },
                                title: Text(
                                    "${searchController.searchResultDm.value.results[index].locations[index].adminArea5},"
                                    "${searchController.searchResultDm.value.results[index].locations[index].adminArea3},"
                                    "${searchController.searchResultDm.value.results[index].locations[index].adminArea1},"));
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
