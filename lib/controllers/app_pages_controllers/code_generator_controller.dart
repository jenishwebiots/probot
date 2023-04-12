import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import '../../config.dart';



class CodeGeneratorController extends GetxController {
  TextEditingController codeController = TextEditingController();
  final FixedExtentScrollController? scrollController = FixedExtentScrollController();
  bool isCodeGenerate = false;
  List codingLanguages = [];

  int value = 0;
  String? selectItem;
  String? onSelect;

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

  endCodeGeneratorDialog() {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return AdviserDialog(title: appFonts.endCodeGenerator,subTitle: appFonts.areYouSureEndCodeGenerator,endOnTap: () {
          isCodeGenerate = false;
          Get.back();
          update();
        },);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300)
    );
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