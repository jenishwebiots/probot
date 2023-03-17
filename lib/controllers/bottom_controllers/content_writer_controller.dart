import 'dart:developer';

import '../../config.dart';

class ContentWriterController extends GetxController {
  String? selectedValue = "businessIdea";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List contentOptionList = [];
  @override
  void onReady() {
    // TODO: implement onReady
contentOptionList = appArray.contentOptionList;
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
