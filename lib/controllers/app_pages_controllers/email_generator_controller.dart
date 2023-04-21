import 'package:probot/config.dart';
import 'package:probot/bot_api/api_services.dart';

class EmailGeneratorController extends GetxController {
  TextEditingController topicController = TextEditingController();
  TextEditingController writeFromController = TextEditingController();
  TextEditingController writeToController = TextEditingController();
  TextEditingController generatedMailController = TextEditingController();
  List toneLists = [];
  List mailLengthLists = [];
  int selectIndex = 0;
  double value = 0;
  bool isMailGenerated = false;
  bool isLoader = false;
  String? response = "";

  onGenerateMail() {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Write a ${selectIndex == 0 ? "Small" : selectIndex == 1 ? "Medium" : "Large"} mail to ${writeToController.text} from ${writeFromController.text} for ${topicController.text} in ${toneLists[selectIndex]} tone").then((value) {
          response = value;
          update();
          isMailGenerated = true;
          isLoader = false;
          update();
    });
    topicController.clear();
    writeFromController.clear();
    writeToController.clear();
    generatedMailController.clear();
    update();
  }

  onToneChange(index) {
    selectIndex = index;
    update();
  }

  endEmailGeneratorDialog() {
    dialogLayout.endDialog(
        title: appFonts.endEmailWriter,
        subTitle: appFonts.areYouSureEndEmail,
        onTap: () {
          topicController.clear();
          writeFromController.clear();
          writeToController.clear();
          generatedMailController.clear();
          isMailGenerated = false;
          Get.back();
          update();
        });
  }

  @override
  void onReady() {
    toneLists = appArray.toneList;
    mailLengthLists = appArray.mailLengthList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
