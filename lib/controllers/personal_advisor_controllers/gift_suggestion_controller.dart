import '../../config.dart';
import 'package:probot/bot_api/api_services.dart';

class GiftSuggestionController extends GetxController {
  TextEditingController sendGiftController = TextEditingController();
  TextEditingController occasionController = TextEditingController();
  TextEditingController generatedSuggestionController = TextEditingController();
  bool isGiftSuggestionGenerate = false;
  bool isLoader = false;
  String? response;

  onGiftSuggestionGenerate() {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "I want to gift ${sendGiftController.text} so please suggest gift for ${occasionController.text} occasion").then((value) {
         response = value;
         update();
         isGiftSuggestionGenerate = true;
         isLoader = false;
         update();
    });
    sendGiftController.clear();
    occasionController.clear();
    update();
  }

  endGiftSuggestion() {
    dialogLayout.endDialog(
        title: appFonts.endGiftSuggestion,
        subTitle: appFonts.areYouSureEndGiftSuggestion,
        onTap: () {
          sendGiftController.clear();
          occasionController.clear();
          isGiftSuggestionGenerate = false;
          Get.back();
          update();
        });
  }
}
