import 'dart:developer';
import 'package:probot/config.dart';
import '../../common/theme/theme_service.dart';


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

    log("isBiometricSave: $isBiometricSave");
    log("isLoginSave: $isLoginSave");
    // Language Save
    Locale? locale = const Locale("en", "US");

  // Theme Save
  bool isTheme = appCtrl.storage.read("isDarkMode") ?? false;
  ThemeService().switchTheme(isTheme);
  appCtrl.isTheme = isTheme;

// Currency Save
    var currency = appCtrl.storage.read("currency") ?? appArray.currencyList[0];
    var currencyCode =
        appCtrl.storage.read("currencyCode") ?? appArray.currencyList[0];
    appCtrl.priceSymbol = currency["symbol"];
    appCtrl.currencyVal =
        double.parse(currencyCode[currency["code"]].toString());

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
                Get.offAllNamed(routeName.dashboard);
              } else {
                if (name != null || userName != null || firebaseUser != null) {
                  if (isLanguageSaved) {
                    if (isCharacterSaved) {
                      if (isBiometricSave) {
                        Get.offAllNamed(routeName.addFingerprintScreen);
                      } else {
                        Get.toNamed(routeName.dashboard);
                      }
                    } else {
                      Get.toNamed(routeName.selectCharacterScreen);
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
