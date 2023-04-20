import '../../config.dart';

class BabyShowerController extends GetxController {
  TextEditingController coupleController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController messageGeneratedController = TextEditingController();
  bool isMessageGenerate = false;

  onWishesGenerate () {
    isMessageGenerate = true;
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