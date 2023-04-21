import 'package:get/get.dart';
import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class FarewellMessageController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController messageGeneratedController = TextEditingController();
  bool isMessageGenerate = false;
  bool isLoader = false;
  String? response = "";

  onWishesGenerate() {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Write a farewell message to name is ${nameController.text} and relation is ${relationController.text} ").then((value) {
         response = value;
         update();
         isMessageGenerate = true;
         isLoader = false;
         update();
    });
    nameController.clear();
    relationController.clear();
    update();
  }

  endWishGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endFarewellMessage,
        subTitle: appFonts.areYouSureEndFarewell,
        onTap: () {
          nameController.clear();
          relationController.clear();
          isMessageGenerate = false;
          Get.back();
          update();
        });
  }
}
