

import '../../config.dart';

class NotificationController extends GetxController {
  List notificationLists = [];

  @override
  void onReady() {
    notificationLists = appArray.notificationList.map((e) => NotificationModel.fromJson(e)).toList();
    update();
    // TODO: implement onReady
    super.onReady();
  }
}