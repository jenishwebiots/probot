import 'package:probot/common/assets/index.dart';

class FirebaseConfigModel {
  String? bannerAddId,
      bannerIOSId,
      rewardAndroidId,
      rewardIOSId,
      razorPayKey,
      razorPaySecret,
      chatGPTKey,
      interstitialAdIdAndroid,
      interstitialAdIdIOS,
      payPalClientId,
      payPalSecret,
      stripeKey,
      stripePublishKey,
      privacyPolicyLink,
      rateAppAndroidId,
      rateAppIOSId,
      refundLink,
      facebookAddAndroidId,
      facebookInterstitialAd,
      facebookRewardAd,
      splashLogo,
      drawerLogo,
      homeLogo;
  bool? isChatShow,isCategorySuggestion,isVoiceEnable,isCameraEnable;
  bool? isImageGeneratorShow;
  int? balance;
  bool? isTextCompletionShow;
  bool? isTheme, isRTL;
  bool? isAddShow,
      isRazorPay,
      isStripe,
      isPaypal,
      isInApp,
      isChatHistory,
      isGuestLoginEnable,
      isGoogleAdmobEnable;

  FirebaseConfigModel(
      {this.bannerAddId,
      this.bannerIOSId,
      this.chatGPTKey,
      this.interstitialAdIdAndroid,
      this.interstitialAdIdIOS,
      this.payPalClientId,
      this.payPalSecret,
      this.stripeKey,
      this.stripePublishKey,
      this.privacyPolicyLink,
      this.refundLink,
      this.rateAppAndroidId,
      this.rateAppIOSId,
      this.isChatShow,
      this.isImageGeneratorShow,
      this.rewardAndroidId,
      this.rewardIOSId,
      this.razorPayKey,
      this.razorPaySecret,
      this.facebookAddAndroidId,
      this.facebookInterstitialAd,
      this.facebookRewardAd,
      this.splashLogo,
      this.drawerLogo,
      this.homeLogo,
      this.isTextCompletionShow,
      this.isAddShow,
      this.isCategorySuggestion,
      this.isVoiceEnable,
      this.isCameraEnable,
      this.isPaypal,
      this.isInApp,
      this.isRazorPay,
      this.isStripe,
      this.isTheme,
      this.isChatHistory,
      this.isGuestLoginEnable,
      this.isGoogleAdmobEnable,
      this.balance});

  FirebaseConfigModel.fromJson(Map<String, dynamic> json) {
    bannerAddId = json['bannerAddId'] ?? "";
    bannerIOSId = json['bannerIOSId'] ?? "";
    rewardAndroidId = json['rewardAndroidId'] ?? "true";
    rewardIOSId = json['rewardIOSId'] ?? "";
    chatGPTKey = json['chatGPTKey'];
    interstitialAdIdAndroid = json['interstitialAdIdAndroid'] ?? "";
    interstitialAdIdIOS = json['interstitialAdIdIOS'] ?? "";
    payPalClientId = json['payPalClientId'] ?? "";
    payPalSecret = json['payPalSecret'] ?? "";
    stripeKey = json['stripeKey'] ?? "";
    stripePublishKey = json['stripePublishKey'] ?? "";
    privacyPolicyLink = json['privacyPolicyLink'] ?? "";
    refundLink = json['refundLink'] ?? "";
    rateAppAndroidId = json['rateAppAndroidId'] ?? "";
    rateAppIOSId = json['rateAppIOSId'] ?? "";
    facebookAddAndroidId = json['facebookAddAndroidId'] ?? "";
    facebookInterstitialAd = json['facebookInterstitialAd'] ?? "";
    splashLogo = json['splashLogo'] ?? eImageAssets.logo1;
    drawerLogo = json['drawerLogo'] ?? "";
    homeLogo = json['homeLogo'] ?? "";
    facebookRewardAd = json['facebookRewardAd'] ?? "";
    isChatShow = json['isChatShow'] ?? true;
    isImageGeneratorShow = json['isImageGeneratorShow'] ?? true;
    isTextCompletionShow = json['isTextCompletionShow'] ?? true;
    isChatHistory = json['isChatHistory'] ?? true;
    isAddShow = json['isAddShow'] ?? true;
    isCategorySuggestion = json['isCategorySuggestion'] ?? true;
    isVoiceEnable = json['isVoiceEnable'] ?? true;
    isCameraEnable = json['isCameraEnable'] ?? true;
    isRTL = json['isRTL'] ?? false;
    isRazorPay = json['isRazorPay'] ?? true;
    isPaypal = json['isPayPal'] ?? true;
    isStripe = json['isStripe'] ?? true;
    isInApp = json['isInApp'] ?? true;
    isTheme = json['isTheme'] ?? false;
    isGuestLoginEnable = json['isGuestLoginEnable'] ?? true;
    isGoogleAdmobEnable = json['isGoogleAdmobEnable'] ?? true;
    razorPayKey = json['razorPayKey'] ?? "";
    razorPaySecret = json['razorPaySecret'] ?? "";
    balance = json['balance'] ?? 5;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bannerAddId'] = bannerAddId;
    data['bannerIOSId'] = bannerIOSId;
    data['chatGPTKey'] = chatGPTKey;
    data['interstitialAdIdAndroid'] = interstitialAdIdAndroid;
    data['interstitialAdIdIOS'] = interstitialAdIdIOS;
    data['payPalClientId'] = payPalClientId;
    data['payPalSecret'] = payPalSecret;
    data['stripeKey'] = stripeKey;
    data['stripePublishKey'] = stripePublishKey;
    data['privacyPolicyLink'] = privacyPolicyLink;
    data['refundLink'] = refundLink;
    data['rateAppAndroidId'] = rateAppAndroidId;
    data['rateAppIOSId'] = rateAppIOSId;
    data['facebookAddAndroidId'] = facebookAddAndroidId;
    data['facebookInterstitialAd'] = facebookInterstitialAd;
    data['facebookRewardAd'] = facebookRewardAd;
    data['splashLogo'] = splashLogo;
    data['drawerLogo'] = drawerLogo;
    data['homeLogo'] = homeLogo;
    data['isChatShow'] = isChatShow;
    data['isImageGeneratorShow'] = isImageGeneratorShow;
    data['isTextCompletionShow'] = isTextCompletionShow;
    data['isAddShow'] = isAddShow;
    data['isStripe'] = isStripe;
    data['isPayPal'] = isPaypal;
    data['isRazorPay'] = isRazorPay;
    data['rewardIOSId'] = rewardIOSId;
    data['rewardAndroidId'] = rewardAndroidId;
    data['razorPayKey'] = razorPayKey;
    data['razorPaySecret'] = razorPaySecret;
    data['isChatHistory'] = isChatHistory;
    data['isRTL'] = isRTL;
    data['isInApp'] = isInApp;
    data['isCategorySuggestion'] = isCategorySuggestion;
    data['isVoiceEnable'] = isVoiceEnable;
    data['isCameraEnable'] = isCameraEnable;
    data['isGuestLoginEnable'] = isGuestLoginEnable;
    data['isGoogleAdmobEnable'] = isGoogleAdmobEnable;
    data['balance'] = balance;
    return data;
  }
}
