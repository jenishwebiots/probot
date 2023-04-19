import '../../config.dart';

class GetWellMessageController extends GetxController {

  TextEditingController wellGenController = TextEditingController();

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