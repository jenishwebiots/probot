import 'dart:developer';
import 'package:probot/bot_api/api_services.dart';
import '../../config.dart';

class BabyNameSuggestionController extends GetxController {
  TextEditingController latterController = TextEditingController();
  TextEditingController generatedNameController = TextEditingController();
  final FixedExtentScrollController? scrollController =
      FixedExtentScrollController();

  List genderLists = [];
  List nameSuggestionLists = [];
  List<String> zodiacLists = [];
  int? selectedIndex = 0;
  int? selectedNameIndex = 0;
  bool isNameGenerate = false;
  int value = 0;
  String? selectItem;
  String? onSelect;

  onGenderChange(index) {
    selectedIndex = index;
    update();
  }

  onNameSuggestionChange(index) {
    selectedNameIndex = index;
    update();
  }

  onNameGenerate() {
    isNameGenerate = true;
    ApiServices.chatCompeletionResponse(selectedNameIndex == 0
        ? "Suggest a ${genderLists[selectedIndex!]['title']} name with ${selectItem ?? "Capricorn"} Zodiac"
        : "Suggest a ${genderLists[selectedIndex!]['title']} name start with ${latterController.text}");
    update();
  }

  endNameSuggestion() {
    dialogLayout.endDialog(
        title: appFonts.endNameSuggestion,
        subTitle: appFonts.areYouSureEndBabyName,
        onTap: () {
          isNameGenerate = false;
          Get.back();
          update();
        });
  }

  onZodiacSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<BabyNameSuggestionController>(builder: (babyCtrl) {
          return LanguagePickerLayout(
            image: eSvgAssets.zodiac,
            title: appFonts.selectLanguage,
            list: babyCtrl.zodiacLists,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(value, babyCtrl.zodiacLists);
            },
            scrollController: babyCtrl.scrollController,
            onSuggestionSelected: (i) {
              int index = babyCtrl.zodiacLists.indexWhere((element) {
                return element == i;
              });
              babyCtrl.scrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              babyCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = babyCtrl.zodiacLists[i];
              log("SELECT ITEM: $selectItem");
              update();
              babyCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              babyCtrl.update();
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
    nameSuggestionLists = appArray.nameSuggestionList;
    zodiacLists = appArray.zodiacList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
