import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_version/new_version.dart';
import 'package:probot/controllers/common_controllers/ad_controller.dart';
import 'package:probot/controllers/common_controllers/in_app_controller.dart';
import 'package:probot/controllers/common_controllers/text_to_speech_controller.dart';

import 'common/languages/index.dart';

import 'config.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  Get.put(InAppController());
  Get.put(AdController());
  Get.put(TextToSpeechController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  void initState() {
    super.initState();

    // Instantiate NewVersion manager object (Using GCP Console app as example)
    final newVersion = NewVersion(
      iOSId: 'com.webiots.probotgpt',
      androidId: 'com.webiots.probotgpt',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = true;

    if (simpleBehavior == true) {
      basicStatusCheck(newVersion);
    } else {
      advancedStatusCheck(newVersion);
    }
  }

  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: Get.context!,
        versionStatus: status,
        dialogTitle: 'Update App',
        dialogText: 'Update Your App',
      );
    }
  }

  @override

  Widget build(BuildContext context) {
    lockScreenPortrait();
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> statusSnapshot) {
          log("STATUS : ${statusSnapshot.data}");
          return  GetMaterialApp(
                  themeMode: ThemeService().theme,
                  theme: AppTheme.fromType(ThemeType.light).themeData,
                  darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
                  locale: const Locale('en', 'US'),
                  translations: Language(),
                  fallbackLocale: const Locale('en', 'US'),
                  home:statusSnapshot.data != ConnectivityResult.none ||
                      statusSnapshot.data != null
                      ?const NoInternet() : SplashScreen(),
                  title: appFonts.proBot.tr,
                  getPages: appRoute.getPages,
                  debugShowCheckedModeBanner: false);
        });
  }

  lockScreenPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
