import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class BabyShowerController extends GetxController {
  TextEditingController coupleController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController messageGeneratedController = TextEditingController();
  bool isMessageGenerate = false;

  onWishesGenerate() {
    isMessageGenerate = true;
    ApiServices.chatCompeletionResponse(
        "Write a baby shower message to ${coupleController.text} from ${relationController.text}");
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
