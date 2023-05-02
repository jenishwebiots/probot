import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class MothersDayWishesController extends GetxController {
  TextEditingController motherController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController wishGeneratedController = TextEditingController();
  bool isWishesGenerate = false;
  bool isLoader = false;
  String? response;
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

  onWishesGenerate() {
    if(scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if(balance == 0){
        appCtrl.balanceTopUpDialog();
      }else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "Write a Mother's day wish message to ${motherController
                .text} from ${relationController.text}").then((value) {
          response = value;
          update();
          isLoader = false;
          isWishesGenerate = true;
        });
        motherController.clear();
        relationController.clear();
        update();
      }}
  }

  endWishGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endMotherDay,
        subTitle: appFonts.areYouSureEndMotherDay,
        onTap: () {
          motherController.clear();
          relationController.clear();
          isWishesGenerate = false;
          Get.back();
          update();
        });
  }
}
