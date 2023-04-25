import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../bot_api/api_services.dart';
import '../../config.dart';



class CodeGeneratorController extends GetxController with GetSingleTickerProviderStateMixin  {
  TextEditingController codeController = TextEditingController();
  final FixedExtentScrollController? scrollController = FixedExtentScrollController();
  bool isCodeGenerate = false;
  bool isLoader = false;
  List codingLanguages = [];
  SpeechToText speech = SpeechToText();
  final FlutterTts? flutterTts = FlutterTts();
  final _isSpeech = false.obs;
  final isListening = false.obs;

  AnimationController? animationController;
  Animation? animation;

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
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animationController!.repeat(reverse: true);
    animation = Tween(begin: 15.0, end: 24.0).animate(animationController!)
      ..addListener(() {
        update();
      });
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

  //stop speech method
  speechStopMethod() async {
    _isSpeech.value = false;
    await flutterTts!.stop();
    update();
  }

  //speech to text
  void speechToText() async {
    speechStopMethod();
    codeController.text = '';

    log("ISLISTEN : ${isListening.value}");
    if (isListening.value == false) {
      bool available = await speech.initialize(
        onStatus: (val) {
          debugPrint('*** onStatus: $val');
          log("loo : ${val == "done"}");
          if (val == "done" || val == "notListening") {
            isListening.value = false;
            update();
          }
          Get.forceAppUpdate();
        },
        onError: (val) {
          debugPrint('### onError: $val');
        },
      );
      log("available ; $available");
      if (available) {
        isListening.value = true;

        speech.listen(
          localeId: appCtrl.languageVal,
          onResult: (val) {
            log("VAL : $val");
            codeController.text = val.recognizedWords.toString();
            update();
          },
          cancelOnError: true,
        );

        update();
      } else {
        log("NO");
      }
    } else {
      isListening.value = false;
      speechStopMethod();
      update();
    }
  }

  @override
  void dispose() {

    animationController!.dispose();
    super.dispose();
  }

}