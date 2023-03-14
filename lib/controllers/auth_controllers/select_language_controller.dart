import '../../config.dart';

class SelectLanguageController extends GetxController {
  List selectLanguageLists = [];
  int selectIndex = 0;

  onLanguageChange(index) {
    selectIndex = index;
    update();
  }
  onContinue() async{
    appCtrl.isLanguage = true;
    await appCtrl.storage.write("isLanguage", appCtrl.isLanguage);
    Get.toNamed(routeName.selectCharacterScreen);
    update();
  }

  @override
  void onReady() async{

    var index = await appCtrl.storage.read("index") ?? 0;
    selectIndex = index;
    selectLanguageLists = appArray.languagesList
        .map((e) => SelectLanguageModel.fromJson(e))
        .toList();
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
