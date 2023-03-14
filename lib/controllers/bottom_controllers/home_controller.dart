



import 'dart:developer';

import '../../config.dart';

class HomeController extends GetxController{
  List<HomeOptionModel> homeOptionList = [];

  @override
  void onReady() {
    // TODO: implement onReady
    homeOptionList = appArray.homeOptionList.map((e) => HomeOptionModel.fromJson(e)).toList();
    update();
    log("homeOptionList : ${homeOptionList.length}");
    super.onReady();
  }
}