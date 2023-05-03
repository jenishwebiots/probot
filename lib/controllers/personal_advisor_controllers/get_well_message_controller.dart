import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class GetWellMessageController extends GetxController {
  TextEditingController wellGenController = TextEditingController();
  TextEditingController wellWishesGenController = TextEditingController();
  TextEditingController relationGenController = TextEditingController();
  TextEditingController whatHappenController = TextEditingController();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
  bool isWellMessageGenerated = false;
  bool isLoader = false;
  String? response;

  onWellMessageGenerate() {
    if(scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if(balance == 0){
        appCtrl.balanceTopUpDialog();
      }else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "get well soon message to ${relationGenController
                .text} ${wellWishesGenController
                .text} for ${whatHappenController.text}").then((value) {
          response = value;
          update();
          isLoader = false;
          isWellMessageGenerated = true;
          update();
        });
        wellGenController.clear();
        wellWishesGenController.clear();
        relationGenController.clear();
        whatHappenController.clear();
        update();
      }}
  }

  endWellWishes() {
    dialogLayout.endDialog(
        title: appFonts.endWellWishes,
        subTitle: appFonts.areYouSureEndWell,
        onTap: () {
          wellGenController.clear();
          wellWishesGenController.clear();
          relationGenController.clear();
          whatHappenController.clear();
              isWellMessageGenerated = false;
          Get.back();
          update();
        });
  }
}
