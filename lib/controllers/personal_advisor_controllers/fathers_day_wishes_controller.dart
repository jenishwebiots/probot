import '../../config.dart';

class FathersDayWishesController extends GetxController {

  TextEditingController fatherController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController wishGeneratedController = TextEditingController();
  bool isWishesGenerate = false;

  onWishesGenerate () {
    isWishesGenerate = true;
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