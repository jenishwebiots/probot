import '../../config.dart';

class DistanceAttractionController extends GetxController {
  TextEditingController controller = TextEditingController();
  SfRangeValues values = const SfRangeValues(10, 20);

 bool isDistanceGenerated = false;

 onDistanceGenerate () {
   isDistanceGenerated = true;
   update();
 }

  endDistanceGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endTraveling,
        subTitle: appFonts.areYouSureEndTravelling,
        onTap: () {
          isDistanceGenerated = false;
          Get.back();
          update();
        });
  }



}
