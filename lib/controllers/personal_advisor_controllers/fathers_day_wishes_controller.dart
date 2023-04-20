import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class FathersDayWishesController extends GetxController {
  TextEditingController fatherController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController wishGeneratedController = TextEditingController();
  bool isWishesGenerate = false;

  onWishesGenerate() {
    isWishesGenerate = true;
    ApiServices.chatCompeletionResponse(
        "Write a Father's day wish message to ${fatherController.text} from ${relationController.text}");
    update();
  }

  endWishGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endFathersDay,
        subTitle: appFonts.areYouSureEndFathersDay,
        onTap: () {
          isWishesGenerate = false;
          Get.back();
          update();
        });
  }
}
