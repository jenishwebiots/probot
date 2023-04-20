import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class GetWellMessageController extends GetxController {
  TextEditingController wellGenController = TextEditingController();
  TextEditingController wellWishesGenController = TextEditingController();
  TextEditingController relationGenController = TextEditingController();
  TextEditingController whatHappenController = TextEditingController();

  bool isWellMessageGenerated = false;

  onWellMessageGenerate() {
    isWellMessageGenerated = true;
    ApiServices.chatCompeletionResponse(
        "get well soon message for ${whatHappenController.text} to ${relationGenController.text}");
    update();
  }

  endWellWishes() {
    dialogLayout.endDialog(
        title: appFonts.endWellWishes,
        subTitle: appFonts.areYouSureEndWell,
        onTap: () {
          isWellMessageGenerated = false;
          Get.back();
          update();
        });
  }
}
