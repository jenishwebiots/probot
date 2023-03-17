import 'dart:developer';

import '../../config.dart';

class SettingController extends GetxController {

  List drawerList = [];
  List settingList = [];
  String? name,userName,firebaseUser;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onReady() {
    // TODO: implement onReady

    drawerList = appArray.drawerList;
    settingList = appArray.settingList;
    name = appCtrl.storage.read("name");
    log("name: $name");
    userName = appCtrl.storage.read("userName");
    log("userName: $userName");
    firebaseUser = appCtrl.storage.read("firebaseUser");
    log("firebaseUser: $firebaseUser");
    update();


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


}
