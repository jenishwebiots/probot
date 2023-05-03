import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class AddApiKeyController extends GetxController {
  TextEditingController apiController = TextEditingController();
  GlobalKey<FormState> addApiGlobalKey = GlobalKey<FormState>();

  onRemoveKey() {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AlertDialogCommon(
              image: eImageAssets.success,
              bText1: appFonts.okay,
              title: appFonts.apiKeyRemoved,
              subtext: appFonts.yourApiKey,
              b1OnTap: () {
                appCtrl.storage.remove(session.chatGPTKey);
                appCtrl.storage.write(session.isChatGPTKey, false);
                appCtrl.isLocalChatApi = false;
                appCtrl.update();
              },
              crossOnTap: () {
                appCtrl.storage.remove(session.chatGPTKey);
                appCtrl.storage.write(session.isChatGPTKey, false);
                appCtrl.isLocalChatApi = false;
                appCtrl.update();
                Get.toNamed(routeName.addApiKeyScreen);
              });
        });
  }

  addApiKeyInLocal() {
    ApiServices.chatCompeletionResponse("ChatGpt").then((value) {
      if (value != "") {
        appCtrl.storage.write(session.chatGPTKey, apiController.text);
        appCtrl.storage.write(session.isChatGPTKey, true);
        appCtrl.isLocalChatApi = true;
        appCtrl.update();
        Get.toNamed(routeName.manageApiKeyScreen);

      } else {
        snackBarMessengers(
          message: appFonts.invalidApiKey.tr,
        );
      }
    });
  }
}
