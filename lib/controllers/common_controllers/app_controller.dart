import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config.dart';

class AppController extends GetxController {
  AppTheme _appTheme = AppTheme.fromType(ThemeType.light);
  RewardedAd? rewardedAd;
  int numRewardedLoadAttempts = 0;

  AppTheme get appTheme => _appTheme;
  String priceSymbol = "\$";
  bool isTheme = false;
  bool isRTL = false;
  bool isLanguage = false;
  bool isCharacter = false;
  bool isBiometric = false;
  bool isLogin = false;
  bool isChatting = false;
  String languageVal = "en";
  dynamic selectedCharacter;
  final storage = GetStorage();
  double currencyVal =
      double.parse(appArray.currencyList[0]["USD"].toString()).roundToDouble();
  bool isSwitched = false;
  bool isOnboard = false;
  bool isGuestLogin = false;
  dynamic currency;
  dynamic envConfig;
  int characterIndex = 3;
  AdRequest request = const AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  FirebaseConfigModel? firebaseConfigModel;

  //update theme
  updateTheme(theme) {
    _appTheme = theme;
    Get.forceAppUpdate();
  }

  //on drawer Tap
  onDrawerTap(index) {
    log("index : E$index");
    Get.back();
    final dashboardCtrl = Get.find<DashboardController>();
    if (index == 0) {
      dashboardCtrl.onBottomTap(1);
    } else if (index == 1) {
      dashboardCtrl.onBottomTap(2);
    } else if (index == 2) {
      dashboardCtrl.onBottomTap(3);
    } else if (index == 3) {
      dashboardCtrl.onBottomTap(4);
    } else if (index == 4) {
      Get.toNamed(routeName.selectLanguageScreen, arguments: true);
    } else {
      FirebaseAuth.instance.signOut();
      appCtrl.storage.erase();
      appCtrl.storage.remove(session.envConfig);
      appCtrl.storage.remove(session.isGuestLogin);
      appCtrl.update();
      Get.forceAppUpdate();
      Get.offAllNamed(routeName.signInScreen);
    }
    dashboardCtrl.update();
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5224354917'
            : 'ca-app-pub-3940256099942544/1712485313',
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            log('$ad loaded.');
            rewardedAd = ad;
            numRewardedLoadAttempts = 0;
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('RewardedAd failed to load: $error');
            rewardedAd = null;
            numRewardedLoadAttempts += 1;
            if (numRewardedLoadAttempts < 3) {
              createRewardedAd();
            }
            update();
          },
        ));
    update();
  }

  void showRewardedAd() async {
    if (rewardedAd == null) {
      log('Warning: attempt to show rewarded before loaded.');
      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          log('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    int count = int.parse(envConfig["chatTextCount"].toString()) + 1;
    envConfig["chatTextCount"] = count.toString();
    log("NEW : ${envConfig["chatTextCount"]}");
    update();
    if (!appCtrl.isGuestLogin) {
      final subscribeCtrl = Get.isRegistered<SubscriptionFirebaseController>()
          ? Get.find<SubscriptionFirebaseController>()
          : Get.put(SubscriptionFirebaseController());
      await subscribeCtrl.addUpdateFirebaseData();
    }
    storage.write(session.envConfig, envConfig);
    envConfig = storage.read(session.envConfig);
    update();

    rewardedAd!.setImmersiveMode(true);
    rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedAd = null;
    showNewCount(envConfig["chatTextCount"]);
    update();
  }

  showNewCount(count) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AlertDialogCommon(
              isReward: true,
              height: Sizes.s160,
              reward: count.toString(),
              image: eGifAssets.coin,
              bText1: appFonts.hurrey,
              title: appFonts.congratulationReward,
              subtext: appFonts.congratulationYouGotNewReward,
              style:
                  AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText),
              b1OnTap: () => Get.back(),
              crossOnTap: () => Get.back());
        });
  }

  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    rewardedAd?.dispose();
    super.dispose();
  }
}
