import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class MothersDayWishesController extends GetxController {
  TextEditingController motherController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController wishGeneratedController = TextEditingController();
  bool isWishesGenerate = false;

  onWishesGenerate() {
    isWishesGenerate = true;
    ApiServices.chatCompeletionResponse(
        "Write a Mother's day wish message to ${motherController.text} from ${relationController.text}");
    update();
  }

  endWishGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endMotherDay,
        subTitle: appFonts.areYouSureEndMotherDay,
        onTap: () {
          isWishesGenerate = false;
          Get.back();
          update();
        });
  }
}
