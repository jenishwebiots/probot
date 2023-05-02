import 'dart:developer';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../bot_api/api_services.dart';
import '../../config.dart';

class EssayWriterController extends GetxController with GetSingleTickerProviderStateMixin {
  TextEditingController essayController = TextEditingController();
  TextEditingController essayGeneratedController = TextEditingController();
  List essayTypeLists = [];
  int selectedIndex = 0;
  bool isEssayGenerated = false;
  bool isLoader = false;
  String? response;
  AnimationController? animationController;
  Animation? animation;
  SpeechToText speech = SpeechToText();
  final _isSpeech = false.obs;
  final FlutterTts? flutterTts = FlutterTts();
  final isListening = false.obs;

  //stop speech method
  speechStopMethod() async {
    _isSpeech.value = false;
    await flutterTts!.stop();
    update();
  }

  //speech to text
  void speechToText() async {
    speechStopMethod();
    essayController.text = '';


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
            essayController.text = val.recognizedWords.toString();
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

  onEssayGenerated() {
    if(essayController.text.isNotEmpty ) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "Write a essay on ${essayController
                .text} in tone of ${selectedIndex == 0
                ? "Informative"
                : selectedIndex == 1 ? "Persuade" : "Analyze"} ").then((value) {
          response = value;
          isEssayGenerated = true;
          isLoader = false;
          update();
        });
        essayController.clear();
        selectedIndex = 0;
        update();
      }
    } else {
      Get.snackbar(appFonts.attention.tr, appFonts.enterTextBoxValue.tr);
    }
  }

  onEssayTypeChange(index) {
    selectedIndex = index;
    update();
  }

  endEssayWriterDialog() {
    Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return AdviserDialog(
              title: appFonts.endEssayWriting,
              subTitle: appFonts.areYouEndEssayWriting,
              endOnTap: () {
                essayController.clear();
                selectedIndex = 0;
                isEssayGenerated = false;
                Get.back();
                update();
              });
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
  }

  @override
  void onReady() {
    addCtrl.onInterstitialAdShow();
    essayTypeLists = appArray.essayTypeList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
