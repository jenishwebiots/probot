import 'dart:developer';

import '../../config.dart';

class SelectLanguageController extends GetxController {
  List selectLanguageLists = [];
  int selectIndex = 0;
  bool isBack = false;

  onLanguageChange(index) {
    selectIndex = index;
    update();
  }

  onContinue() async {
    appCtrl.isLanguage = true;
    await appCtrl.storage.write("isLanguage", appCtrl.isLanguage);
    if(isBack){
      Get.back();
    }else {
      Get.toNamed(routeName.dashboard);
    }
    update();
  }

  @override
  void onReady() async {
    isBack = Get.arguments ?? false;
    var index = await appCtrl.storage.read("index") ?? 0;
    selectIndex = index;
    selectLanguageLists = appArray.languagesList
        .map((e) => SelectLanguageModel.fromJson(e))
        .toList();
    update();
    log("isBack : $isBack");
    // TODO: implement onReady
    super.onReady();
  }
}
