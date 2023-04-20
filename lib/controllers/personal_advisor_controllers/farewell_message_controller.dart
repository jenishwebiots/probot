import 'package:get/get.dart';

import '../../config.dart';

class FarewellMessageController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController messageGeneratedController = TextEditingController();
  bool isMessageGenerate = false;

  onWishesGenerate () {
    isMessageGenerate = true;
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