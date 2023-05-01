import 'package:probot/config.dart';
import 'package:probot/bot_api/api_services.dart';

class CvMakerController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController customController = TextEditingController();
  TextEditingController generatedCvController = TextEditingController();

  bool isCvGenerate = false;
  String? response;
  bool isLoader = false;

  onCvGenerate() {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Write a CV with name ${nameController.text} ,phone number ${phoneController.text} ,email ${mailController.text} ,position looking for ${positionController.text} ,experience ${experienceController.text} and want job for ${jobController.text} also want to add ${customController.text}").then((value) {
          response = value;
          update();
          isCvGenerate = true;
          isLoader = false;
          update();
    });
    nameController.clear();
    phoneController.clear();
    mailController.clear();
    positionController.clear();
    experienceController.clear();
    jobController.clear();
    customController.clear();
    update();
  }

  endCvMaker() {
    dialogLayout.endDialog(
        title: appFonts.endMyCv,
        subTitle: appFonts.areYouSureEndCv,
        onTap: () {
          nameController.clear();
          phoneController.clear();
          mailController.clear();
          positionController.clear();
          experienceController.clear();
          jobController.clear();
          customController.clear();
          isCvGenerate = false;
          Get.back();
          update();
        });
  }
}
