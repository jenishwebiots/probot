class FirebaseConfigModel {
  String? bannerAddId;
  String? bannerIOSId;
  String? chatGPTKey;
  String? interstitialAdIdAndroid;
  String? interstitialAdIdIOS;
  String? payPalClientId;
  String? payPalSecret;
  String? stripeKey;
  String? stripePublishKey;
  bool? isChatShow;
  bool? isImageGeneratorShow;
  bool? isTextCompletionShow;
  bool? isAddShow;

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
      this.isChatShow,
      this.isImageGeneratorShow,
      this.isTextCompletionShow,this.isAddShow});

  FirebaseConfigModel.fromJson(Map<String, dynamic> json) {
    bannerAddId = json['bannerAddId'];
    bannerIOSId = json['bannerIOSId'];
    chatGPTKey = json['chatGPTKey'];
    interstitialAdIdAndroid = json['interstitialAdIdAndroid'];
    interstitialAdIdIOS = json['interstitialAdIdIOS'];
    payPalClientId = json['payPalClientId'];
    payPalSecret = json['payPalSecret'];
    stripeKey = json['stripeKey'];
    stripePublishKey = json['stripePublishKey'];
    isChatShow = json['isChatShow'];
    isImageGeneratorShow = json['isImageGeneratorShow'];
    isTextCompletionShow = json['isTextCompletionShow'];
    isAddShow = json['isAddShow'];
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
    data['isChatShow'] = isChatShow;
    data['isImageGeneratorShow'] = isImageGeneratorShow;
    data['isTextCompletionShow'] = isTextCompletionShow;
    data['isAddShow'] = isAddShow;
    return data;
  }
}
