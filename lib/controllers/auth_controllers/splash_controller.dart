import 'dart:developer';
import 'package:probot/config.dart';


class SplashController extends GetxController {
@override
  void onReady() async{

  bool isLanguageSaved = appCtrl.storage.read("isLanguage") ?? false;
  bool isCharacterSaved = appCtrl.storage.read("isCharacter") ?? false;
  appCtrl.isCharacter = isCharacterSaved;
  appCtrl.isLanguage = isLanguageSaved;
  // Language Save
  Locale? locale = const Locale("en", "US");

  var language =
      await appCtrl.storage.read("locale") ?? const Locale("en", "US");
  if (language != null) {
    if (language == "en") {
      locale = const Locale("en", "US");
    } else if (language == "hi") {
      locale = const Locale("hi", "IN");
    } else if (language == "it") {
      locale = const Locale("it", "IT");
    } else if (language == "fr") {
      locale = const Locale("fr", "CA");
    } else if (language == "ge") {
      locale = const Locale("ge", "GE");
    } else if (language == "ja") {
      locale = const Locale("ja", "JP");
    }
  } else {
    locale = const Locale("en", "US");
  }

  Get.updateLocale(locale);
  appCtrl.update();
  Get.forceAppUpdate();

  bool onBoard = appCtrl.storage.read("isOnboard") ?? false;
  var name = appCtrl.storage.read("name");
  var userName = appCtrl.storage.read("userName");
  var firebaseUser = appCtrl.storage.read("firebaseUser");
   appCtrl.isOnboard = onBoard;
  Future.delayed(const Duration(seconds: 3),() {

    if(onBoard) {
     if (name != null || userName != null || firebaseUser != null) {
       if(isLanguageSaved) {
         if(isCharacterSaved) {
           Get.toNamed(routeName.addFingerprintScreen);
         } else {
         Get.toNamed(routeName.selectCharacterScreen);}
       } else {
      Get.toNamed(routeName.selectLanguageScreen);}
    } else {
       Get.toNamed(routeName.loginScreen);
     }
    }else {
      Get.toNamed(routeName.onBoardingScreen);
    }
    update();
  });
  update();
    // TODO: implement onReady
    super.onReady();
  }
}