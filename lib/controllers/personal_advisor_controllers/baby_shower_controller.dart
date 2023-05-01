import 'dart:developer';

import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class BabyShowerController extends GetxController {
  TextEditingController coupleController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController messageGeneratedController = TextEditingController();
  bool isMessageGenerate = false;
  bool isLoader = false;
  String? response;

  onWishesGenerate() {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
            "Write a baby shower message to ${coupleController.text} from ${relationController.text}")
        .then((value) {
      response = value;
      update();
      isLoader = false;
      isMessageGenerate = true;
      update();
    });
    coupleController.clear();
    relationController.clear();
    update();
  }

  endWishGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endBirthdayMessage,
        subTitle: appFonts.areYouSureEndBabyShower,
        onTap: () {
          coupleController.clear();
          relationController.clear();
          isMessageGenerate = false;
          Get.back();
          update();
        });
  }
}
