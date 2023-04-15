import 'dart:developer';

import 'package:probot/config.dart';

class TravelController extends GetxController {
  List travelList = [];

  onGoPage(value) {
    if (value["title"] == appFonts.nearbyPoints) {
      Get.toNamed(
          routeName.nearbyPointsScreen);
    } else {
      /*Get.toNamed(
          routeName.hashtagForPostScreen);*/
    }
    update();
  }

  @override
  void onReady() {
    travelList = appArray.travelHangoutList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
