import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class PromotionWishesController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController wishGeneratedController = TextEditingController();
  bool isWishesGenerate = false;

  onWishesGenerate() {
    isWishesGenerate = true;
    ApiServices.chatCompeletionResponse(
        "Write a promotion wish message to ${nameController.text} from ${relationController.text}");
    update();
  }

  endWishGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endPromotionWish,
        subTitle: appFonts.areYouSureEndPromotion,
        onTap: () {
          isWishesGenerate = false;
          Get.back();
          update();
        });
  }
}
