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

  onCvGenerate() {
    isCvGenerate = true;
    ApiServices.chatCompeletionResponse(
        "Write a CV with name ${nameController.text} ,phone number ${phoneController.text} ,email ${mailController.text} ,position looking for ${positionController.text} ,experience ${experienceController.text} and want job for ${jobController.text} also want to add ${customController.text}");
    update();
  }

  endCvMaker() {
    dialogLayout.endDialog(
        title: appFonts.endMyCv,
        subTitle: appFonts.areYouSureEndCv,
        onTap: () {
          isCvGenerate = false;
          Get.back();
          update();
        });
  }
}
