import 'dart:developer';

import '../../config.dart';

class NewYearGreetingController extends GetxController {

  bool isGreetingGenerate = false;
  final FixedExtentScrollController? languageScrollController = FixedExtentScrollController();
  TextEditingController yearController = TextEditingController();
  TextEditingController sendWishesController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController newYearWishGenController = TextEditingController();

  int value = 0;
  String? selectItem;
  String? onSelect;

  final langCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());

  onNewYearWishesGenerate () {
    isGreetingGenerate = true;
    update();
  }

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<NewYearGreetingController>(builder: (newYearCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: newYearCtrl.langCtrl.translateLanguagesList,
            index: newYearCtrl.value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, newYearCtrl.langCtrl.translateLanguagesList);
            },
            scrollController: newYearCtrl.languageScrollController,
            onSuggestionSelected: (i) {
              int index = newYearCtrl.langCtrl.translateLanguagesList
                  .indexWhere((element) {
                return element == i;
              });
              newYearCtrl.languageScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              newYearCtrl.update();
            },
            onSelectedItemChanged: (i) {
              newYearCtrl.value = i;
              newYearCtrl.selectItem = newYearCtrl.langCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              newYearCtrl.update();
            },
            selectOnTap: () {
              newYearCtrl.onSelect = newYearCtrl.selectItem;
              Get.back();
              newYearCtrl.update();
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

  endNewYearGreeting() {
    dialogLayout.endDialog(
        title: appFonts.endNewYearGreeting,
        subTitle: appFonts.areYouSureEndGreeting,
        onTap: () {
          isGreetingGenerate = false;
          Get.back();
          update();
        });
  }

}