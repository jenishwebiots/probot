import 'package:get/get.dart';
import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class FarewellMessageController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController messageGeneratedController = TextEditingController();
  bool isMessageGenerate = false;

  onWishesGenerate() {
    isMessageGenerate = true;
    ApiServices.chatCompeletionResponse(
        "Write a farewell message to name is ${nameController.text} and relation is ${relationController.text} ");
    update();
  }

  endWishGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endFarewellMessage,
        subTitle: appFonts.areYouSureEndFarewell,
        onTap: () {
          isMessageGenerate = false;
          Get.back();
          update();
        });
  }
}
