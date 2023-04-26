import 'dart:developer';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AllowNotificationController extends GetxController {
  @override
  void onReady() async{
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      log("GRANTED PERMISSION");
    }
    else {
      log("NO PERMISSION");
      openAppSettings();
      update();
    }
    // TODO: implement onReady
    super.onReady();
    update();
  }
}