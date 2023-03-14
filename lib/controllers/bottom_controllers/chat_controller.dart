import 'dart:developer';

import '../../config.dart';

class ChatController extends GetxController {
  List chatOptionList = [];
  List drawerList = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onReady() {
    // TODO: implement onReady
    chatOptionList = appArray.selectCharacterList;
    drawerList = appArray.drawerList;
    update();
    super.onReady();
  }
}
