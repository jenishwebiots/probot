import 'dart:developer';
import '../../bot_api/api_services.dart';
import '../../config.dart';

class TranslateController extends GetxController {
  TextEditingController transController = TextEditingController();
  TextEditingController transCompleteController = TextEditingController();
  bool isTranslated = false;
  bool isLoader = false;
  var selectItem;
  var toSelectItem;
  var onFromSelect;
  var onToSelect;
  String? response = '';
  int value = 0;
  int toValue = 0;
  List<String> translateLanguagesList = [];
  final FixedExtentScrollController? fromScrollController =
      FixedExtentScrollController();
  final FixedExtentScrollController? toScrollController =
      FixedExtentScrollController();
  final ScrollController? thumbScrollController =
      ScrollController(initialScrollOffset: 50.0);

  @override
  void onReady() {
    translateLanguagesList = appArray.translateLanguages;
    update();
    // TODO: implement onReady
    super.onReady();
  }

  onTranslate () {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Translate ${transController.text} from ${onFromSelect ?? appFonts.english} to ${onToSelect ?? appFonts.hindi} language").then((value) {
          response = value;
          update();
          isTranslated = true;
          isLoader = false;
          update();
    });
    update();
  }

  endTranslationDialog() {
    dialogLayout.endDialog(
        title: appFonts.endTranslation,
        subTitle: appFonts.areYouSure,
        onTap: () {
          transController.clear();
          isTranslated = false;
          Get.back();
          update();
        });
  }

  // from languages list
  onFromLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<TranslateController>(builder: (translateCtrl) {
          return LanguagePickerLayout(
            list: translateLanguagesList,
            title: appFonts.selectLanguage,
            index: value,
            scrollController: translateCtrl.fromScrollController,
            thumbScrollController: thumbScrollController,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(value, translateLanguagesList);
            },
            onSuggestionSelected: (i) {
              int index = translateCtrl.translateLanguagesList.indexWhere((element) {
                return element == i;
              });
              translateCtrl.fromScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              translateCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              translateCtrl.update();
            },
            selectOnTap: () {
              onFromSelect = selectItem;
              Get.back();
              translateCtrl.update();
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

  // to language list
  onToLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<TranslateController>(builder: (translateCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: translateLanguagesList,
            index: toValue,
            scrollController: translateCtrl.toScrollController,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(value, translateLanguagesList);
            },
            onSelectedItemChanged: (i) {
              toValue = i;
              toSelectItem = translateLanguagesList[i];
              log("SELECT ITEM: $toSelectItem");
              update();
              translateCtrl.update();
            },
            onSuggestionSelected: (i) {
              int index = translateCtrl.translateLanguagesList.indexWhere((element) {
                return element == i;
              });
              translateCtrl.toScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              translateCtrl.update();
            },
            selectOnTap: () {
              onToSelect = toSelectItem;
              Get.back();
              translateCtrl.update();
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
