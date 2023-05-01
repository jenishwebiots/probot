import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../config.dart';

class AdController extends GetxController {

  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;

  AdManagerBannerAd? adManagerBannerAd;
  bool adManagerBannerAdIsLoaded = false;
  bool isInterstitialAdLoaded = false;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  NativeAd? nativeAd;

  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );
  bool nativeAdIsLoaded = false;

  bool isSubscribe = appCtrl.storage.read(session.isSubscribe) ?? false;

  onInterstitialAdShow () {

    if (appCtrl.firebaseConfigModel!.isAddShow! && isSubscribe == false) {
      if (appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!) {
        showInterstitialAd();
      } else {
        log("FB");
        loadInterstitialAd();

      }
    }
    update();
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // Unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // Unique ID on Android
    }
  }

  _showBannerAd() {
    log("SHOW BANNER");
    currentAd = FacebookBannerAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: appCtrl.firebaseConfigModel!.facebookAddAndroidId!,
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        print("Banner Ad: $result -->  $value");
      },
    );
    update();
    log("_currentAd : $currentAd");
  }

  buildBanner() async {
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


  void loadInterstitialAd() {
    FacebookAudienceNetwork.init(
      testingId: "1b24a79a-1b2a-447d-82dc-7759ef992604",
      iOSAdvertiserTrackingEnabled: true,
    );

    FacebookInterstitialAd.loadInterstitialAd(
      placementId: appCtrl.firebaseConfigModel!.facebookInterstitialAd!,
      listener: (result, value) {
        log("result : $result");
        log("result1 : ${result.name}");
        log("result2 : $value");
        if (result == InterstitialAdResult.LOADED) {
          FacebookInterstitialAd.showInterstitialAd(delay: 5000);
        }
      },
    );
  }

  showFbInterstitialAd() {
    if (isInterstitialAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd();
    } else {
      print("Interstial Ad not yet loaded!");
    }
  }

  //initialize interstitial add
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? appCtrl.firebaseConfigModel!.interstitialAdIdAndroid!
            : appCtrl.firebaseConfigModel!.interstitialAdIdIOS!,
        request: appCtrl.request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            log('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < 3) {
              _createInterstitialAd();
            }
          },
        ));
    update();
    appCtrl.createRewardedAd();
  }

  //show interstitial add
  void showInterstitialAd() {
    if (_interstitialAd == null) {
      log('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          log('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
    update();
  }


  @override
  void onReady() {

    if (bannerAd == null) {
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
    } else {
      bannerAd!.dispose();
      buildBanner();
    }

    _getId().then((id)  {
      String? deviceId = id;

      FacebookAudienceNetwork.init(
        testingId: "1b24a79a-1b2a-447d-82dc-7759ef992604",
        iOSAdvertiserTrackingEnabled: true,
      );

    });
    _showBannerAd();
    update();

    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    bannerAd?.dispose();
    bannerAd = null;
    super.dispose();
  }

}