import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
                      log("DDD : ${snapshot.data!.docs}");
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
