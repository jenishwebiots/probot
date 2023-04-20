import '../../config.dart';

class MothersDayWishesController extends GetxController {

  TextEditingController motherController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController wishGeneratedController = TextEditingController();
  bool isWishesGenerate = false;

  onWishesGenerate () {
    isWishesGenerate = true;
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