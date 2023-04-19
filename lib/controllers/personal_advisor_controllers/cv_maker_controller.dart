import 'package:probot/config.dart';

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

   onCvGenerate () {
      isCvGenerate = true;
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