import 'package:probot/config.dart';

class TravelController extends GetxController {
  List travelList = [];

  onGoPage(value) {
    if (value["title"] == appFonts.nearbyPoints) {
      Get.toNamed(routeName.nearbyPointsScreen);
    } else {
      Get.toNamed(routeName.distanceAttractionScreen);
    }
    update();
  }

  @override
  void onReady() {
    addCtrl.onInterstitialAdShow();
    travelList = appArray.travelHangoutList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
