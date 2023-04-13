import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_version/new_version.dart';
import 'package:probot/controllers/common_controllers/in_app_controller.dart';
import 'package:probot/widgets/no_internet.dart';
import 'common/languages/index.dart';

import 'config.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  Get.put(InAppController());
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
          return statusSnapshot.data != ConnectivityResult.none &&
                  statusSnapshot.data != null
              ? StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("config")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      appCtrl.firebaseConfigModel =
                          FirebaseConfigModel.fromJson(
                              snapshot.data!.docs[0].data());
                      Stripe.publishableKey =
                          appCtrl.firebaseConfigModel!.stripePublishKey!;
                      appCtrl.storage.write(session.firebaseConfig,
                          snapshot.data!.docs[0].data());
                      appCtrl.update();
                    }
                    return GetMaterialApp(
                        themeMode: ThemeService().theme,
                        theme: AppTheme.fromType(ThemeType.light).themeData,
                        darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
                        locale: const Locale('en', 'US'),
                        translations: Language(),
                        fallbackLocale: const Locale('en', 'US'),
                        home: SplashScreen(),
                        title: appFonts.proBot.tr,
                        getPages: appRoute.getPages,
                        debugShowCheckedModeBanner: false);
                  })
              : GetMaterialApp(
                  themeMode: ThemeService().theme,
                  theme: AppTheme.fromType(ThemeType.light).themeData,
                  darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
                  locale: const Locale('en', 'US'),
                  translations: Language(),
                  fallbackLocale: const Locale('en', 'US'),
                  home: NoInternet(
                    connectionStatus: statusSnapshot.data,
                  ),
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
