import '../../config.dart';

class SocialMediaController extends GetxController {
  TextEditingController captionController = TextEditingController();

  List socialMediaLists = [];
  List captionCreatorLists = [];
  int selectedIndex = 0;

  SfRangeValues values = const SfRangeValues(40, 60);

  onCaptionChange(index) {
    selectedIndex = index;
    update();
  }

  @override
  void onReady() {
    captionCreatorLists = appArray.captionCreatorList;
    socialMediaLists = appArray.socialMediaList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
