import '../../config.dart';

class AddApiKeyController extends GetxController {
  TextEditingController apiController = TextEditingController();

  onRemoveKey () {
    showDialog(
        barrierDismissible: false,
        context: Get.context!, builder: (context) {
      return AlertDialogCommon(
          image: eImageAssets.success,
          bText1: appFonts.okay,
          title: appFonts.apiKeyRemoved,
          subtext: appFonts.yourApiKey,
          b1OnTap: (){
            appCtrl.storage.remove(session.chatGPTKey);
            appCtrl.storage.write(session.isChatGPTKey, false);
            appCtrl.update();
          },
          crossOnTap: ()=> Get.toNamed(routeName.addApiKeyScreen)
      );
    });
  }

}
