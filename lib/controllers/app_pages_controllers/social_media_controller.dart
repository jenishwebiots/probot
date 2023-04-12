import '../../config.dart';

class SocialMediaController extends GetxController {
    List socialMediaLists = [];

    @override
  void onReady() {
      socialMediaLists = appArray.socialMediaList;
      update();
    // TODO: implement onReady
    super.onReady();
  }

}