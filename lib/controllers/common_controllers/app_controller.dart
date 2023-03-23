import 'dart:developer';

import 'package:probot/models/firebase_config.dart';

import '../../config.dart';

class AppController extends GetxController {
  AppTheme _appTheme = AppTheme.fromType(ThemeType.light);

  AppTheme get appTheme => _appTheme;
  String priceSymbol = "\$";
  bool isTheme = false;
  bool isRTL = false;
  bool isLanguage = false;
  bool isCharacter = false;
  bool isBiometric = false;
  bool isLogin = false;
  bool isChatting = false;
  String languageVal = "en";
  dynamic selectedCharacter;
  final storage = GetStorage();
  double currencyVal = double.parse(appArray.currencyList[0]["USD"].toString()).roundToDouble();
  bool isSwitched = false;
  bool isOnboard = false;
  dynamic currency;
  dynamic envConfig;
  int characterIndex= 3;
  FirebaseConfigModel? firebaseConfigModel;

  //update theme
  updateTheme(theme) {
    _appTheme = theme;
    Get.forceAppUpdate();
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
    } else if (index == 3) {
      dashboardCtrl.onBottomTap(4);
    } else if (index == 4) {
      Get.toNamed(routeName.selectLanguageScreen, arguments: true);
    }
    dashboardCtrl.update();
  }


}
