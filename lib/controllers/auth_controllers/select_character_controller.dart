import '../../config.dart';

class SelectCharacterController extends GetxController {
  List selectCharacterLists = [];
  int selectIndex = 1;

  onCharacterChange(index) {
    selectIndex = index;
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
