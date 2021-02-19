import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tourtracking/model/searchResult.dart';
import 'package:tourtracking/utils/appConstant.dart';

class SearchController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  var searchResultDm = SearchResult().obs;
  var isLoading = false.obs;

  void searchAction() async {
    if (searchTextController.text.isEmpty) {
      Get.snackbar('Error', 'Invalid');
    } else {
      isLoading.value = true;
      var headers = {'Cookie': 'JSESSIONID=478173FD20A9E48078167AF286B21AEB'};
      var request = http.Request(
          'GET', Uri.parse('${AppConstant.url}${searchTextController.text}'));

      print("Url ${AppConstant.url}${searchTextController.text} ");
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      isLoading.value= false;

      if (response.statusCode == 200) {
        print("Search response $response");
        searchResultDm.value = searchResultFromJson(response.body);

        print("city>>> ${searchResultDm.value.info.copyright.imageAltText}");
      } else {
        print(response.reasonPhrase);
      }
    }
  }
}
