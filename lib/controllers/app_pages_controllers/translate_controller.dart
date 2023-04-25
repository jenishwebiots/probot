import 'dart:developer';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../bot_api/api_services.dart';
import '../../config.dart';

class TranslateController extends GetxController with GetSingleTickerProviderStateMixin  {
  TextEditingController transController = TextEditingController();
  TextEditingController transCompleteController = TextEditingController();
  bool isTranslated = false;
  final FlutterTts? flutterTts = FlutterTts();
  bool isLoader = false;
  dynamic selectItem;
  dynamic toSelectItem;
  dynamic onFromSelect;
  dynamic onToSelect;
  String? response = '';
  int value = 0;

  AnimationController? animationController;
  Animation? animation;

  SpeechToText speech = SpeechToText();

  final _isSpeech = false.obs;
  final isListening = false.obs;
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


  //stop speech method
  speechStopMethod() async {
    _isSpeech.value = false;
    await flutterTts!.stop();
    update();
  }

  //speech to text
  void speechToText() async {
    speechStopMethod();
    transController.text = '';

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
            transController.text = val.recognizedWords.toString();
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
