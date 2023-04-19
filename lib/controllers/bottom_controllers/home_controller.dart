import 'dart:developer';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config.dart';

class HomeController extends GetxController {
  List<HomeOptionModel> homeOptionList = [];
  List drawerList = [];
  List quickAdvisorLists = [];
  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;

  AdManagerBannerAd? adManagerBannerAd;
  bool adManagerBannerAdIsLoaded = false;

  NativeAd? nativeAd;
  bool nativeAdIsLoaded = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onReady() {
    // TODO: implement onReady
    homeOptionList = appArray.homeOptionList
        .map((e) => HomeOptionModel.fromJson(e))
        .toList();
    drawerList = appArray.drawerList;
    quickAdvisorLists = appArray.quickAdvisor.getRange(0, 6).toList();
    update();

    log("bannerAdIsLoaded : $bannerAdIsLoaded");
    if(bannerAd == null) {
      bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: Platform.isAndroid
              ? appCtrl.firebaseConfigModel!.bannerAddId!
              : appCtrl.firebaseConfigModel!.bannerIOSId!,
          listener: BannerAdListener(
            onAdLoaded: (Ad ad) {
              log('$BannerAd loaded.');
              bannerAdIsLoaded = true;
              update();
            },
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              log('$BannerAd failedToLoad: $error');
              ad.dispose();
            },
            onAdOpened: (Ad ad) => log('$BannerAd onAdOpened.'),
            onAdClosed: (Ad ad) => log('$BannerAd onAdClosed.'),

          ),
          request: const AdRequest())
        ..load();
      log("Home Banner : $bannerAd");
    }else{
      bannerAd!.dispose();
      buildBanner();
    }
    update();
    super.onReady();
  }

  buildBanner()async{
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid
            ? appCtrl.firebaseConfigModel!.bannerAddId!
            : appCtrl.firebaseConfigModel!.bannerIOSId!,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            log('$BannerAd loaded.');
            bannerAdIsLoaded = true;
            update();
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            log('$BannerAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => log('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => log('$BannerAd onAdClosed.'),

        ),
        request: const AdRequest())
      ..load();
    log("Home Banner AGAIn: $bannerAd");
  }

  //on option tap function
  onOptionTap(data) {
    log("TITLE : $data");
    final dashboardCtrl = Get.find<DashboardController>();
    if (data.title == "option1") {
      dashboardCtrl.onBottomTap(1);
    } else if (data.title == "option2") {
      dashboardCtrl.onBottomTap(2);
    } else {
      dashboardCtrl.onBottomTap(3);
    }
    dashboardCtrl.update();
  }

  onTapWatch() {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {


          return AlertDialogCommon(
              isReward: true,
              height: Sizes.s160,
              reward: appCtrl.envConfig["chatTextCount"].toString(),
              image: eImageAssets.reward,
              bText1: appFonts.watchVideo,
              title: appFonts.availableBalance.tr,
              subtext: appFonts.watchTheVideoToWin,
              style:
                  AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText),
              b1OnTap: () {
                Get.back();
                Get.back();
                if(appCtrl.rewardedAd == null) {
                  appCtrl.createRewardedAd();
                }
                appCtrl.showRewardedAd();
              },
              crossOnTap: () => Get.back());
        });
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    bannerAd?.dispose();
    bannerAd=null;
    super.dispose();
  }
}
