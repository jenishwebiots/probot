import '../../config.dart';

class SelectLanguageController extends GetxController {
  List selectLanguageLists = [];
  int selectIndex = 0;

  onLanguageChange(index) {
    selectIndex = index;
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
