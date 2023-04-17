import '../../config.dart';

class PersonalAdvisorController extends GetxController {
     List personalAdvisorLists = [];

     onGoPage (value) {
       if (value["title"] == appFonts.babyNameSuggestion) {
         Get.toNamed(routeName.babyNameScreen);
       } else if (value["title"] == appFonts.cvMaker) {
         Get.toNamed(routeName.cvMakerScreen);
       }
     }

     @override
  void onReady() {
       personalAdvisorLists = appArray.personalAdvisorList;
       update();
    // TODO: implement onReady
    super.onReady();
  }

}