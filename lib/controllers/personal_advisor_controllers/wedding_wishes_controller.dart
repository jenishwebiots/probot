import 'dart:developer';
import 'package:probot/bot_api/api_services.dart';
import '../../config.dart';

class WeddingWishesController extends GetxController {
  List<String> anniversaryYearList =
      List<String>.generate(70, (counter) => "${counter + 1}");
  final FixedExtentScrollController? anniYearScrollController =
      FixedExtentScrollController();
  final FixedExtentScrollController? languageScrollController =
      FixedExtentScrollController();
  TextEditingController wishGenController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  int value = 0;
  int langValue = 0;
  String? selectItem;
  String? langSelectItem;
  String? onSelect;
  String? langOnSelect;
  String? response;
  bool isWeddingWishGenerate = false;
  bool isLoader = false;

  final langCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

  onMessageGenerate() {
    if(scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "I want to wish ${nameController
                .text} for wedding to ${relationController
                .text} in ${selectItem ?? "English"}").then((value) {
          response = value;
          update();
          isLoader = false;
          isWeddingWishGenerate = true;
          update();
        });
        wishGenController.clear();
        relationController.clear();
        nameController.clear();
        selectItem = '';
        langSelectItem = '';
        update();
      }}
  }

  endWeddingWishes() {
    dialogLayout.endDialog(
        title: appFonts.endWeddingWishes,
        subTitle: appFonts.areYouSureEndWedding,
        onTap: () {
          wishGenController.clear();
          relationController.clear();
          nameController.clear();
          selectItem = '';
          langSelectItem = '';
          isWeddingWishGenerate = false;
          Get.back();
          update();
        });
  }

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<WeddingWishesController>(builder: (weddingCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: weddingCtrl.langCtrl.translateLanguagesList,
            index: langValue,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, weddingCtrl.langCtrl.translateLanguagesList);
            },
            scrollController: weddingCtrl.languageScrollController,
            onSuggestionSelected: (i) {
              int index = weddingCtrl.langCtrl.translateLanguagesList
                  .indexWhere((element) {
                return element == i;
              });
              weddingCtrl.languageScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              weddingCtrl.update();
            },
            onSelectedItemChanged: (i) {
              langValue = i;
              langSelectItem = weddingCtrl.langCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              weddingCtrl.update();
            },
            selectOnTap: () {
              langOnSelect = langSelectItem;
              Get.back();
              weddingCtrl.update();
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

  onWeddingAnniSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<WeddingWishesController>(builder: (weddingCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: weddingCtrl.anniversaryYearList,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, weddingCtrl.anniversaryYearList);
            },
            scrollController: weddingCtrl.anniYearScrollController,
            onSuggestionSelected: (i) {
              int index = weddingCtrl.anniversaryYearList.indexWhere((element) {
                return element == i;
              });
              weddingCtrl.anniYearScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              weddingCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = weddingCtrl.anniversaryYearList[i];
              log("SELECT ITEM: $selectItem");
              update();
              weddingCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              weddingCtrl.update();
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
