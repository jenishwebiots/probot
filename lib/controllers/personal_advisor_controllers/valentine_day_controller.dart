import 'dart:developer';

import '../../config.dart';

class ValentineDayController extends GetxController {
  final transCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());

  TextEditingController valWishGenController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController wishForController = TextEditingController();
  final FixedExtentScrollController? scrollController =
      FixedExtentScrollController();

  String? selectItem;
  String? onSelectItem;
  int value = 0;

  bool isValentineGenerate = false;

  onValWishesGenerate() {
    isValentineGenerate = true;
    update();
  }

  endValentine() {
    dialogLayout.endDialog(
        title: appFonts.endValentineMessage,
        subTitle: appFonts.areYouSureEndValentine,
        onTap: () {
          isValentineGenerate = false;
          Get.back();
          update();
        });
  }

  onToLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<ValentineDayController>(builder: (valCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: valCtrl.transCtrl.translateLanguagesList,
            index: value,
            scrollController: valCtrl.scrollController,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, valCtrl.transCtrl.translateLanguagesList);
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = valCtrl.transCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              valCtrl.update();
            },
            onSuggestionSelected: (i) {
              int index = valCtrl.transCtrl.translateLanguagesList
                  .indexWhere((element) {
                return element == i;
              });
              valCtrl.scrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              valCtrl.update();
            },
            selectOnTap: () {
              onSelectItem = selectItem;
              Get.back();
              valCtrl.update();
            },
          );
        });
      }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppRadius.r10),
            topLeft: Radius.circular(AppRadius.r10)),
      ),
    );
  }
}
