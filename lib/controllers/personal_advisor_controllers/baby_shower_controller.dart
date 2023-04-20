import 'dart:developer';

import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class BabyShowerController extends GetxController {
  TextEditingController coupleController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController messageGeneratedController = TextEditingController();
  bool isMessageGenerate = false;

  onWishesGenerate() {
    ApiServices.chatCompeletionResponse(
            "Write a baby shower message to ${coupleController.text} from ${relationController.text}")
        .then((value) => {
              log("RESPONSE++++++++++++++++++++$value"),
              messageGeneratedController.text = value,
              update(),
              isMessageGenerate = true,
              update(),
            });
    update();
  }

  endWishGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endBirthdayMessage,
        subTitle: appFonts.areYouSureEndBabyShower,
        onTap: () {
          isMessageGenerate = false;
          Get.back();
          update();
        });
  }
}
