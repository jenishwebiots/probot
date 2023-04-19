import 'dart:developer';

import 'package:probot/config.dart';

class NewBabyWishesController extends GetxController {
  final FixedExtentScrollController? languageScrollController =
      FixedExtentScrollController();

  TextEditingController wishGenController = TextEditingController();

  final langCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());

  List genderLists = [];
  int selectIndex = 0;
  int langValue = 0;
  String? langSelectItem;
  String? langOnSelect;
  bool isWishGenerate = false;

  onWishesGenerate() {
    isWishGenerate = true;
    update();
  }

  onGenderChange(index) {
    selectIndex = index;
    update();
  }

  endBabyWishesSuggestion() {
    dialogLayout.endDialog(
        title: appFonts.endBornBabyWish,
        subTitle: appFonts.areYouSureEndBabyName,
        onTap: () {
          isWishGenerate = false;
          Get.back();
          update();
        });
  }

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<NewBabyWishesController>(builder: (newCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: newCtrl.langCtrl.translateLanguagesList,
            index: langValue,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, newCtrl.langCtrl.translateLanguagesList);
            },
            scrollController: newCtrl.languageScrollController,
            onSuggestionSelected: (i) {
              int index =
                  newCtrl.langCtrl.translateLanguagesList.indexWhere((element) {
                return element == i;
              });
              newCtrl.languageScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              newCtrl.update();
            },
            onSelectedItemChanged: (i) {
              langValue = i;
              langSelectItem = newCtrl.langCtrl.translateLanguagesList[i];

              update();
              newCtrl.update();
            },
            selectOnTap: () {
              langOnSelect = langSelectItem;
              Get.back();
              newCtrl.update();
            },
          );
        });
      }),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppRadius.r10),
              topLeft: Radius.circular(AppRadius.r10))),
    );
  }

  @override
  void onReady() {
    genderLists = appArray.genderList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
