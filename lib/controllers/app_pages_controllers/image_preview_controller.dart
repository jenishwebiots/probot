import 'dart:developer';

import '../../config.dart';


class ImagePreviewController extends GetxController {
  dynamic image;



  @override
  void onReady() {
    var data = Get.arguments;
    image = data ?? "";
    update();
    // TODO: implement onReady
    super.onReady();
  }
}