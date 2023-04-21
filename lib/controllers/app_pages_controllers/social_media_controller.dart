import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:probot/bot_api/api_services.dart';
import '../../config.dart';

class SocialMediaController extends GetxController {
  TextEditingController captionController = TextEditingController();
  TextEditingController captionGeneratedController = TextEditingController();
  TextEditingController musicGeneratedController = TextEditingController();
  TextEditingController hashtagController = TextEditingController();
  TextEditingController hashtagGeneratedController = TextEditingController();
  final FixedExtentScrollController? scrollController =
      FixedExtentScrollController();
  final FixedExtentScrollController? categoryScrollController =
      FixedExtentScrollController();
  double progressValue = 0;

  final languageCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());

  List socialMediaLists = [];
  List captionCreatorLists = [];
  List captionToneLists = [];
  List musicCategoryList = [];
  int selectedIndex = 0;
  int selectedIndexTone = 0;
  bool isCaptionGenerated = false;
  bool isMusicGenerated = false;
  bool isHashtagGenerated = false;
  bool isLoader = false;
  int value = 0;
  String? selectItem;
  String? onSelect;
  int categoryValue = 0;
  String? categorySelectItem;
  String? categoryOnSelect;
  String? hashtagResponse = '';
  String? captionResponse = '';
  String? musicResponse = '';

  SfRangeValues values = const SfRangeValues(30, 40);

  void updateProgress() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      progressValue += 0.03;
      update();
    });
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('json_class/genres.json');
    final data = await json.decode(response);
    musicCategoryList = data;
    update();
  }

  onCaptionGenerate() {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Please give me best ${captionToneLists[selectedIndexTone]['title']} caption Suggestion for ${captionCreatorLists[selectedIndex]['title']} platform for ${captionController.text} photo").then((value) {
         captionResponse = value;
         update();
         isCaptionGenerated = true;
         isLoader = false;
         update();
    });
    update();
  }

  onMusicGenerate() {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Please give me music Suggestion ${categorySelectItem ?? "Classic"} category and in ${selectItem ?? "Hindi"} for post").then((value) {
          musicResponse = value;
          update();
          isMusicGenerated = true;
          isLoader = false;
          update();
    });
    update();
  }

  onCaptionToneChange(index) {
    selectedIndexTone = index;
    update();
  }

  onPlatformChange(index) {
    selectedIndex = index;
    update();
  }

  onGoPage(value) {
    if (value["title"] == appFonts.captionAbout) {
      Get.toNamed(routeName.captionCreatorScreen);
    } else if (value["title"] == appFonts.getMusicSuggestion) {
      Get.toNamed(routeName.musicForPostScreen);
    } else {
      Get.toNamed(routeName.hashtagForPostScreen);
    }
  }

  onHashtagGenerate() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      progressValue += 0.03;
      update();
    });
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Please give me Hashtag Suggestion for ${hashtagController.text} post").then((value) {
      hashtagResponse = value;
      isHashtagGenerated = true;
      isLoader = false;
      progressValue = 0.0;
      update();
    });
    update();
  }

  endCaptionGeneratorDialog() {
    dialogLayout.endDialog(
        title: appFonts.endCaptionGenerator,
        subTitle: appFonts.areYouSureEndCodeGenerator,
        onTap: () {
          captionController.clear();
          isCaptionGenerated = false;
          Get.back();
          update();
        });
  }

  onSelectLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: languageCtrl.translateLanguagesList,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, languageCtrl.translateLanguagesList);
            },
            scrollController: socialMediaCtrl.scrollController,
            onSuggestionSelected: (i) {
              int index =
                  languageCtrl.translateLanguagesList.indexWhere((element) {
                return element == i;
              });
              socialMediaCtrl.scrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              socialMediaCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = languageCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              socialMediaCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              socialMediaCtrl.update();
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

  onSelectMusicCategorySheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
          return LanguagePickerLayout(
            image: eSvgAssets.music,
            title: appFonts.selectMusicCategory,
            list: socialMediaCtrl.musicCategoryList,
            index: socialMediaCtrl.categoryValue,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, socialMediaCtrl.musicCategoryList.cast<String>());
            },
            scrollController: socialMediaCtrl.categoryScrollController,
            onSuggestionSelected: (i) {
              int index =
                  socialMediaCtrl.musicCategoryList.indexWhere((element) {
                return element == i;
              });
              socialMediaCtrl.categoryScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              socialMediaCtrl.update();
            },
            onSelectedItemChanged: (i) {
              socialMediaCtrl.categoryValue = i;
              categorySelectItem = socialMediaCtrl.musicCategoryList[i];
              log("SELECT ITEM: $categorySelectItem");
              update();
              socialMediaCtrl.update();
            },
            selectOnTap: () {
              categoryOnSelect = categorySelectItem;
              Get.back();
              socialMediaCtrl.update();
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

  endMusicGeneratorDialog() {
    dialogLayout.endDialog(
        title: appFonts.endMusicGeneration,
        subTitle: appFonts.areYouSureEndMusic,
        onTap: () {
          musicGeneratedController.clear();
          isMusicGenerated = false;
          Get.back();
          update();
        });
  }

  endHashtagGeneratorDialog() {
    dialogLayout.endDialog(
        title: appFonts.endHashtagBuilder,
        subTitle: appFonts.areYouSureEndCodeGenerator,
        onTap: () {
          hashtagController.clear();
          isHashtagGenerated = false;
          Get.back();
          update();
        });
  }

  @override
  void onReady() {
    readJson();
    captionCreatorLists = appArray.captionCreatorList;
    socialMediaLists = appArray.socialMediaList;
    captionToneLists = appArray.captionToneList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
