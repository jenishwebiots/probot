import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class AddApiKeyController extends GetxController {
  TextEditingController apiController = TextEditingController();


  addApiKeyInLocal() {
    ApiServices.chatCompeletionResponse("ChatGpt",addApiKey: apiController.text).then((value) {
      if (value != "") {
        appCtrl.storage.write(session.chatGPTKey, apiController.text);
        appCtrl.storage.write(session.isChatGPTKey, true);
        appCtrl.isLocalChatApi = true;
        appCtrl.update();
        Get.back();
      } else {
        snackBarMessengers(
          message: appFonts.invalidApiKey.tr,
        );
      }
    });
  }

  @override
  void onReady() {
    update();
    // TODO: implement onReady
    super.onReady();
  }

}
