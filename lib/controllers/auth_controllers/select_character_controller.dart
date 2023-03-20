import '../../config.dart';

class SelectCharacterController extends GetxController {
  List selectCharacterLists = [];
  int selectIndex = 1;

  onCharacterChange(index) {
    selectIndex = index;
    update();
  }

  onContinue() async{
    appCtrl.isCharacter = true;
    await appCtrl.storage.write("isCharacter", appCtrl.isCharacter);
    Get.toNamed(routeName.dashboard);
    update();
  }

  @override
  void onReady() {
    selectCharacterLists = appArray.selectCharacterList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
