import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourtracking/controller/search_controller.dart';
import 'package:tourtracking/main.dart';
import 'package:tourtracking/widget/customTextField.dart';
class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {

  var searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Add Location'),),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 12.0, bottom: 12.0, right: 10.0),
                child: Container(width: mainWidth*.8,
                    child: CustomTextField(controller: searchController.searchTextController, hints: 'Search')),
              ),
              GestureDetector(
                onTap: (){
                  searchController.searchAction();
                },
                child: Container(
                    width: size.width*.12,
                    height: size.height*.06,
                    //padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFE3E8F0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(Icons.search)),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(title: Text('${searchController.searchResultDm.value.results[0].providedLocation.location}, Bogura, Rangpur, Barisal'),);
                }




            ),
          )
        ],
      ),
    );
  }
}
