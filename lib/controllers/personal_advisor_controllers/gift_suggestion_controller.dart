import '../../config.dart';
import 'package:probot/bot_api/api_services.dart';

class GiftSuggestionController extends GetxController {
  TextEditingController sendGiftController = TextEditingController();
  TextEditingController occasionController = TextEditingController();
  TextEditingController generatedSuggestionController = TextEditingController();
  bool isGiftSuggestionGenerate = false;

  onGiftSuggestionGenerate() {
    isGiftSuggestionGenerate = true;
    ApiServices.chatCompeletionResponse(
        "I want to gift ${sendGiftController.text} so please suggest gift for ${occasionController.text} occasion");
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
