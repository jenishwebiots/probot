import 'dart:developer';
import 'package:probot/config.dart';


class SplashController extends GetxController {
  @override
  void onReady() async {
    bool isLoginSave = appCtrl.storage.read("isLogin") ?? false;
    bool isBiometricSave = appCtrl.storage.read("isBiometric") ?? false;
    bool isLanguageSaved = appCtrl.storage.read("isLanguage") ?? false;
    bool isCharacterSaved = appCtrl.storage.read("isCharacter") ?? false;
    appCtrl.isCharacter = isCharacterSaved;
    appCtrl.isLanguage = isLanguageSaved;
    appCtrl.isBiometric = isBiometricSave;
    appCtrl.isLogin = isLoginSave;
    appCtrl.selectedCharacter = appCtrl.storage.read("selectedCharacter") ??
        appArray.selectCharacterList[3];
    appCtrl.characterIndex = appCtrl.storage.read("characterIndex") ?? 3;
    log("isBiometricSave: $isBiometricSave");
    log("isLoginSave: $isLoginSave");
    // Language Save
    Locale? locale = const Locale("en", "US");

    // Theme Save
    bool isTheme = appCtrl.storage.read("isDarkMode") ?? false;
    ThemeService().switchTheme(isTheme);
    appCtrl.isTheme = isTheme;

    var language =
        await appCtrl.storage.read("locale") ?? "en";
  log("language ; $language");
    if (language != null) {
      appCtrl.languageVal =language;
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
    var name = appCtrl.storage.read("name") ;
    log("name: $name");
    var userName = appCtrl.storage.read("userName");
    log("userName: $userName");
    var firebaseUser = appCtrl.storage.read("firebaseUser");
    log("firebaseUser: $firebaseUser");
    log("condition: ${name != null || userName != null || firebaseUser != null}");
    appCtrl.isOnboard = onBoard;

    Future.delayed(const Duration(seconds: 3), () {
      if (onBoard) {
        if (isLoginSave) {
          if (isBiometricSave) {
            Get.offAllNamed(routeName.addFingerprintScreen);
          } else {
            Get.toNamed(routeName.dashboard);
          }
        } else {
          if (name != null || userName != null || firebaseUser != null) {
            if (isLanguageSaved) {
              if (isBiometricSave) {
                Get.offAllNamed(routeName.addFingerprintScreen);
              } else {
                Get.toNamed(routeName.dashboard);
              }
            } else {
              Get.toNamed(routeName.selectLanguageScreen);
            }
          } else {
            Get.toNamed(routeName.loginScreen);
          }
        }
      } else {
        Get.toNamed(routeName.onBoardingScreen);
      }
      update();
    });
  }
}
