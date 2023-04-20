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

  onGenerateMail() {
    isMailGenerated = true;
    ApiServices.chatCompeletionResponse(
        "Write a ${mailLengthLists[2]} mail to ${writeToController.text} from ${writeFromController.text} for ${topicController.text} in ${toneLists[selectIndex]} tone");
    update();
  }

  onToneChange(index) {
    selectIndex = index;
    update();
  }

  endEmailGeneratorDialog() {
    Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return AdviserDialog(
              title: appFonts.endEmailWriter,
              subTitle: appFonts.areYouSureEndEmail,
              endOnTap: () {
                isMailGenerated = false;
                Get.back();
                update();
              });
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
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
