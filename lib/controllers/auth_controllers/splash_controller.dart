import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:probot/config.dart';
import 'package:probot/models/category_access_model.dart';

import '../../env.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    bool onBoard = appCtrl.storage.read("isOnboard") ?? false;
    var name = appCtrl.storage.read("name");
    var userName = appCtrl.storage.read("userName");
    var firebaseUser = appCtrl.storage.read("firebaseUser");
    var number = appCtrl.storage.read("number");
    log("number : $number");
    appCtrl.isOnboard = onBoard;
    appCtrl.envConfig = appCtrl.storage.read(session.envConfig) ?? environment;

    update();
    dynamic selectedImage =
        appCtrl.storage.read("backgroundImage") ?? appArray.backgroundList[0];
    appCtrl.storage.write("backgroundImage", selectedImage);
    log("SPLASH BG : $selectedImage");
    await FirebaseFirestore.instance.collection("config").get().then((value) {
      if (value.docs.isNotEmpty) {
        appCtrl.firebaseConfigModel =
            FirebaseConfigModel.fromJson(value.docs[0].data());
        Stripe.publishableKey = appCtrl.firebaseConfigModel!.stripePublishKey!;
        appCtrl.isTheme = appCtrl.firebaseConfigModel!.isTheme!;
        appCtrl.isRTL = appCtrl.firebaseConfigModel!.isRTL!;
        appCtrl.storage.write(session.isRTL, appCtrl.isRTL);
        appCtrl.update();
        ThemeService().switchTheme(appCtrl.isTheme);
        Get.forceAppUpdate();
        appCtrl.storage.write(session.firebaseConfig, value.docs[0].data());
        appCtrl.envConfig["balance"] = appCtrl.firebaseConfigModel!.balance;
        appCtrl.update();
        appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
      }
    });

    //category hide show
    await FirebaseFirestore.instance
        .collection("categoryAccess")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        appCtrl.categoryAccessModel =
            CategoryAccessModel.fromJson(value.docs[0].data());
        appCtrl.update();
        Get.forceAppUpdate();
        appCtrl.storage.write(session.categoryConfig, value.docs[0].data());
      }
    });

    if (!appCtrl.isGuestLogin && userName != null) {
      await FirebaseFirestore.instance
          .collection("userSubscribe")
          .where("email", isEqualTo: appCtrl.storage.read("userName"))
          .limit(1)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          if (value.docs[0].data()["isSubscribe"] == false) {
            appCtrl.envConfig["balance"] = value.docs[0].data()["balance"];
            appCtrl.update();
            appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
            appCtrl.storage.write(session.isSubscribe, false);
          } else {
            appCtrl.storage.write(session.isSubscribe, true);
          }
          appCtrl.storage.write(session.isAnySubscribe, true);
        } else {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
            if (value.exists) {
              appCtrl.envConfig["balance"] = value.data()!["balance"];
              appCtrl.update();
              appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
            }
          });
        }
      });
    } else {
      appCtrl.storage.write(session.isAnySubscribe, false);
      log("appCtrl.envConfig : ${appCtrl.envConfig}");
      appCtrl.envConfig["balance"] = appCtrl.firebaseConfigModel!.balance ?? 5;
      appCtrl.envConfig = appCtrl.storage.read(session.envConfig);
    }
    appCtrl.update();
    bool isLoginSave = appCtrl.storage.read(session.isLogin) ?? false;
    bool isGuestLogin = appCtrl.storage.read(session.isGuestLogin) ?? false;
    bool isBiometricSave = appCtrl.storage.read(session.isBiometric) ?? false;
    bool isLanguageSaved = appCtrl.storage.read(session.isLanguage) ?? false;
    bool isCharacterSaved = appCtrl.storage.read(session.isCharacter) ?? false;
    appCtrl.isCharacter = isCharacterSaved;
    appCtrl.isLanguage = isLanguageSaved;
    appCtrl.isBiometric = isBiometricSave;
    appCtrl.isLogin = isLoginSave;

    //select Character as per selected or guest
    if (appCtrl.isGuestLogin) {
      await FirebaseFirestore.instance
          .collection("characters")
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          appCtrl.selectedCharacter = value.docs[3].data();
          appCtrl.storage.write(session.characterIndex, 3);
          appCtrl.characterIndex =
              appCtrl.storage.read(session.characterIndex) ?? 3;
          appCtrl.characterIndex =
              appCtrl.storage.read(session.characterIndex) ?? 3;
          appCtrl.update();
        }
      });
    } else {
      if (appCtrl.selectedCharacter == null) {
        await FirebaseFirestore.instance
            .collection("characters")
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            appCtrl.selectedCharacter = value.docs[3].data();
            appCtrl.storage.write(session.characterIndex, 3);
            appCtrl.characterIndex =
                appCtrl.storage.read(session.characterIndex) ?? 3;
            appCtrl.characterIndex =
                appCtrl.storage.read(session.characterIndex) ?? 3;
            appCtrl.update();
          }
        });
      }
    }

    log("isBiometricSave: $isBiometricSave");
    log("isLoginSave: $isLoginSave");
    // Language Save
    Locale? locale = const Locale("en", "US");

    // Theme Save
    bool isTheme = appCtrl.storage.read(session.isDarkMode) ?? false;
    ThemeService().switchTheme(isTheme);
    appCtrl.isTheme = isTheme;

    //language
    var language = await appCtrl.storage.read(session.locale) ?? "en";
    log("language ; $language");
    if (language != null) {
      appCtrl.languageVal = language;
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

    //currency
    appCtrl.currency =
        await appCtrl.storage.read("currency") ?? appArray.currencyList[0];

    appCtrl.priceSymbol = appCtrl.currency["symbol"];
    if (appCtrl.currency["title"] == "dollar") {
      appCtrl.currencyVal =
          double.parse(appArray.currencyList[0]["USD"].toString())
              .roundToDouble();
    } else if (appCtrl.currency["title"] == "euro") {
      appCtrl.currencyVal =
          double.parse(appArray.currencyList[0]["EUR"].toString())
              .roundToDouble();
    } else if (appCtrl.currency["title"] == "inr") {
      appCtrl.currencyVal =
          double.parse(appArray.currencyList[0]["INR"].toString())
              .roundToDouble();
    } else {
      appCtrl.currencyVal =
          double.parse(appArray.currencyList[0]["POU"].toString())
              .roundToDouble();
    }

    update();
    Future.delayed(const Duration(seconds: 3), () {
      log("onBoard : $onBoard");
      final isSubscribe = appCtrl.storage.read(session.isAnySubscribe) ?? false;
      appCtrl.isSubscribe = appCtrl.storage.read(session.isSubscribe) ?? false;

      if (onBoard) {
        if (isSubscribe) {
          if (isGuestLogin) {
            appCtrl.isGuestLogin = isGuestLogin;
            appCtrl.storage.write(session.isGuestLogin, isGuestLogin);
            Get.toNamed(routeName.dashboard);
          } else {
            log("onBoard : $onBoard");
            appCtrl.isGuestLogin = false;
            appCtrl.storage.write(session.isGuestLogin, false);

            if (isLoginSave) {
              if (isBiometricSave) {
                Get.offAllNamed(routeName.addFingerprintScreen);
              } else {
                Get.toNamed(routeName.dashboard);
              }
            } else {
              if (name != null ||
                  userName != null ||
                  firebaseUser != null ||
                  number != null) {
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
          }
        } else {
          Get.toNamed(routeName.subscriptionPlanList, arguments: false);
        }
      } else {
        Get.toNamed(routeName.onBoardingScreen);
      }

      update();
    });
  }
}
