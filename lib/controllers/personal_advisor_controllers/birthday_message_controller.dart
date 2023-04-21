import 'dart:developer';
import 'package:probot/bot_api/api_services.dart';
import '../../config.dart';

class BirthdayMessageController extends GetxController {
  TextEditingController birthdayMessagesGenController = TextEditingController();
  TextEditingController birthdayWishGenController = TextEditingController();
  TextEditingController nameGenController = TextEditingController();

  bool isBirthdayGenerated = false;
  bool isLoader = false;
  String? response = '';

  final FixedExtentScrollController? scrollController =
      FixedExtentScrollController();
  int value = 0;
  String? selectItem;
  String? onSelect;
  final langCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());

  onTapWishesGenerate() {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Birthday wish message for ${birthdayWishGenController.text} with ${nameGenController.text} name in ${selectItem ?? "Hindi"}").then((value) {
          response = value;
          update();
          isBirthdayGenerated = true;
          isLoader = false;
          update();
    });
    birthdayMessagesGenController.clear();
    birthdayWishGenController.clear();
    nameGenController.clear();
    selectItem = "";
    update();
  }

  endNameSuggestion() {
    dialogLayout.endDialog(
        title: appFonts.endBirthdayMessage,
        subTitle: appFonts.areYouSureEndBirthday,
        onTap: () {
          birthdayMessagesGenController.clear();
          birthdayWishGenController.clear();
          nameGenController.clear();
          selectItem = "";
          isBirthdayGenerated = false;
          Get.back();
          update();
        });
  }

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<BirthdayMessageController>(builder: (birthdayCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: birthdayCtrl.langCtrl.translateLanguagesList,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, birthdayCtrl.langCtrl.translateLanguagesList);
            },
            scrollController: birthdayCtrl.scrollController,
            onSuggestionSelected: (i) {
              int index = birthdayCtrl.langCtrl.translateLanguagesList
                  .indexWhere((element) {
                return element == i;
              });
              birthdayCtrl.scrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              birthdayCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = birthdayCtrl.langCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              birthdayCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              birthdayCtrl.update();
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
