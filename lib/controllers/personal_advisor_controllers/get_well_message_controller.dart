import '../../config.dart';

class GetWellMessageController extends GetxController {

  TextEditingController wellGenController = TextEditingController();
  TextEditingController wellWishesGenController = TextEditingController();
  TextEditingController relationGenController = TextEditingController();
  TextEditingController whatHappenController = TextEditingController();

   bool isWellMessageGenerated = false;

   onWellMessageGenerate () {
     isWellMessageGenerated = true;
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