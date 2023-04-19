import 'dart:developer';

import '../../config.dart';

class AnniversaryMessageController extends GetxController {
  List<String> anniversaryYearList =
      List<String>.generate(70, (counter) => "${counter + 1}");
  final FixedExtentScrollController? anniYearScrollController =
      FixedExtentScrollController();
  final FixedExtentScrollController? languageScrollController =
      FixedExtentScrollController();
  TextEditingController wishGenController = TextEditingController();

  int value = 0;
  int langValue = 0;
  String? selectItem;
  String? langSelectItem;
  String? onSelect;
  String? langOnSelect;
  bool isMessageGenerate = false;

  final langCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());

  onMessageGenerate() {
    isMessageGenerate = true;
    update();
  }

  endNameSuggestion() {
    dialogLayout.endDialog(
        title: appFonts.endAnniversaryMessage,
        subTitle: appFonts.areYouSureEndAnniversary,
        onTap: () {
          isMessageGenerate = false;
          Get.back();
          update();
        });
  }

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<AnniversaryMessageController>(builder: (anniCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: anniCtrl.langCtrl.translateLanguagesList,
            index: langValue,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, anniCtrl.langCtrl.translateLanguagesList);
            },
            scrollController: anniCtrl.languageScrollController,
            onSuggestionSelected: (i) {
              int index = anniCtrl.langCtrl.translateLanguagesList
                  .indexWhere((element) {
                return element == i;
              });
              anniCtrl.languageScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              anniCtrl.update();
            },
            onSelectedItemChanged: (i) {
              langValue = i;
              langSelectItem = anniCtrl.langCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              anniCtrl.update();
            },
            selectOnTap: () {
              langOnSelect = langSelectItem;
              Get.back();
              anniCtrl.update();
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

  onAnniYearSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<AnniversaryMessageController>(builder: (anniCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: anniCtrl.anniversaryYearList,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, anniCtrl.anniversaryYearList);
            },
            scrollController: anniCtrl.anniYearScrollController,
            onSuggestionSelected: (i) {
              int index = anniCtrl.anniversaryYearList.indexWhere((element) {
                return element == i;
              });
              anniCtrl.anniYearScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              anniCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = anniCtrl.anniversaryYearList[i];
              log("SELECT ITEM: $selectItem");
              update();
              anniCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              anniCtrl.update();
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
}