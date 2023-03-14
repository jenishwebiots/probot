import 'dart:developer';

import '../../config.dart';

class HomeController extends GetxController {
  List<HomeOptionModel> homeOptionList = [];
  List drawerList = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onReady() {
    // TODO: implement onReady
    homeOptionList = appArray.homeOptionList
        .map((e) => HomeOptionModel.fromJson(e))
        .toList();
    drawerList = appArray.drawerList;
    update();
    log("homeOptionList : ${homeOptionList.length}");
    super.onReady();
  }

  //on option tap function
  onOptionTap(index) {
    final dashboardCtrl = Get.find<DashboardController>();
    if (index == 0) {
      dashboardCtrl.onBottomTap(1);
    } else if (index == 1) {
      dashboardCtrl.onBottomTap(2);
    } else {
      dashboardCtrl.onBottomTap(3);
    }
    dashboardCtrl.update();
  }

  //on drawer Tap
  onDrawerTap(index) {
    log("index : E$index");
    Get.back();
    final dashboardCtrl = Get.find<DashboardController>();
    if (index == 0) {
      dashboardCtrl.onBottomTap(1);
    } else if (index == 1) {
      dashboardCtrl.onBottomTap(2);
    } else if (index == 2) {
      dashboardCtrl.onBottomTap(3);
    } else if (index == 3){
      dashboardCtrl.onBottomTap(4);
    }else if (index == 4){
      Get.toNamed(routeName.selectLanguageScreen,arguments: true);
    }
    dashboardCtrl.update();
  }
}
