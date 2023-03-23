import 'dart:developer';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config.dart';
import '../../env.dart';

class HomeController extends GetxController {
  List<HomeOptionModel> homeOptionList = [];
  List drawerList = [];
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
    update();

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
    log("bannerAd : $bannerAd");
    update();
    super.onReady();
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
              reward: "50",
              image: eImageAssets.reward,
              bText1: appFonts.watchVideo,
              title: appFonts.availableBalance,
              subtext: appFonts.watchTheVideoToWin,
              style:
                  AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText),
              b1OnTap: () {
                Get.back();
                showDialog(
                    barrierDismissible: false,
                    context: Get.context!,
                    builder: (context) {
                      return AlertDialogCommon(
                          isReward: true,
                          height: Sizes.s160,
                          reward: "51",
                          image: eGifAssets.coin,
                          bText1: appFonts.hurrey,
                          title: appFonts.congratulationReward,
                          subtext: appFonts.congratulationYouGotNewReward,
                          style: AppCss.outfitMedium14
                              .textColor(appCtrl.appTheme.lightText),
                          b1OnTap: () => Get.back(),
                          crossOnTap: () => Get.back());
                    });
              },
              crossOnTap: () => Get.back());
        });
  }
}
