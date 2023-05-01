import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class PromotionWishesController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController wishGeneratedController = TextEditingController();
  bool isWishesGenerate = false;
  bool isLoader = false;
  String? response;

  onWishesGenerate() {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Write a promotion wish message to ${nameController.text} from ${relationController.text}").then((value) {
          response = value;
          update();
          isLoader = false;
          isWishesGenerate = true;
    });
    relationController.clear();
    nameController.clear();
    update();
  }

  endWishGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endPromotionWish,
        subTitle: appFonts.areYouSureEndPromotion,
        onTap: () {
          relationController.clear();
          nameController.clear();
          isWishesGenerate = false;
          Get.back();
          update();
        });
  }
}
