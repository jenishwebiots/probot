import '../../config.dart';

class PersonalAdvisorController extends GetxController {
  List personalAdvisorLists = [];

  onGoPage(value) {
    if (value["title"] == appFonts.babyNameSuggestion) {
      Get.toNamed(routeName.babyNameScreen);
    } else if (value["title"] == appFonts.cvMaker) {
      Get.toNamed(routeName.cvMakerScreen);
    } else if (value["title"] == appFonts.giftSuggestion) {
      Get.toNamed(routeName.giftSuggestionScreen);
    } else if (value["title"] == appFonts.birthdayMessage) {
      Get.toNamed(routeName.birthdayMessageScreen);
    } else if (value["title"] == appFonts.anniversaryMessage) {
      Get.toNamed(routeName.anniversaryMessageScreen);
    } else if (value["title"] == appFonts.newBabyWishes) {
      Get.toNamed(routeName.newBabyWishesScreen);
    } else if (value["title"] == appFonts.valentineDay) {
      Get.toNamed(routeName.valentineScreen);
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
