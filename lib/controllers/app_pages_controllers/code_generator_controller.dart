import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import '../../bot_api/api_services.dart';
import '../../config.dart';



class CodeGeneratorController extends GetxController {
  TextEditingController codeController = TextEditingController();
  final FixedExtentScrollController? scrollController = FixedExtentScrollController();
  bool isCodeGenerate = false;
  bool isLoader = false;
  List codingLanguages = [];

  int value = 0;
  String? selectItem;
  String? onSelect;
  String? response = "";

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('json_class/languages.json');
    final  data = await json.decode(response);
    codingLanguages = data;
    update();
  }

@override
  void onReady() {
    readJson();
    update();
    // TODO: implement onReady
    super.onReady();
  }

  onCodeGenerate () {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Write a code for ${codeController.text} in ${onSelect ?? "C#"} language").then((value) {
          response = value;
          isCodeGenerate = true;
          isLoader = false;
          update();
    });
    codeController.clear();
    update();
  }

  endCodeGeneratorDialog() {
    dialogLayout.endDialog(
        title: appFonts.endCodeGenerator,
        subTitle: appFonts.areYouSureEndCodeGenerator,
        onTap: () {
          codeController.clear();
          onSelect = 'C#';
          isCodeGenerate = false;
          Get.back();
          update();
        });
  }

  // from languages list
  onSelectLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<CodeGeneratorController>(
            builder: (codeGeneratorCtrl) {
              return  LanguagePickerLayout(
                image: eSvgAssets.code,
                title: appFonts.selectCodeLanguage,
                list: codingLanguages,
                index: value,
                suggestionsCallbacks: (value) {
                  return StateService.getSuggestions(value,codingLanguages.cast<String>());
                },
                scrollController: codeGeneratorCtrl.scrollController,
                onSuggestionSelected: (i) {
                  int index =
                  codingLanguages.indexWhere((element) {
                    return element == i;
                  });
                  codeGeneratorCtrl.scrollController!.jumpToItem(index);
                  log("suggestion: $i");
                  log("index: $index");
                  update();
                  codeGeneratorCtrl.update();
                },
                onSelectedItemChanged: (i) {
                  value = i;
                  selectItem = codingLanguages[i];
                  log("SELECT ITEM: $selectItem");
                  update();
                  codeGeneratorCtrl.update();
                },
                selectOnTap: () {
                  onSelect = selectItem;
                  Get.back();
                  codeGeneratorCtrl.update();
                },
              );
            }
        );
      }),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppRadius.r10),
              topLeft: Radius.circular(AppRadius.r10))
      ),
    );
  }

}