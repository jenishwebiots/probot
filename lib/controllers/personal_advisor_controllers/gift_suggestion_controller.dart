import '../../config.dart';

class GiftSuggestionController extends GetxController {

     TextEditingController sendGiftController = TextEditingController();
     TextEditingController occasionController = TextEditingController();
     TextEditingController generatedSuggestionController = TextEditingController();
     bool isGiftSuggestionGenerate = false;

     onGiftSuggestionGenerate () {
          isGiftSuggestionGenerate = true;
          update();
     }

     endGiftSuggestion() {
          dialogLayout.endDialog(
              title: appFonts.endGiftSuggestion,
              subTitle: appFonts.areYouSureEndGiftSuggestion,
              onTap: () {
                   isGiftSuggestionGenerate = false;
                   Get.back();
                   update();
              });
     }
}