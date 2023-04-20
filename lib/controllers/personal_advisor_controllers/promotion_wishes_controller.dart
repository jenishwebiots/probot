
import '../../config.dart';

class PromotionWishesController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController wishGeneratedController = TextEditingController();
  bool isWishesGenerate = false;

  onWishesGenerate () {
    isWishesGenerate = true;
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