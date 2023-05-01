import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../config.dart';

class AdCommonLayout extends StatelessWidget {
  final AlignmentGeometry? alignment;
  const AdCommonLayout({Key? key,this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!appCtrl.isSubscribe)
          if (appCtrl.firebaseConfigModel!.isAddShow!)
            appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!
                ? (addCtrl.bannerAd != null && addCtrl.bannerAdIsLoaded)
                ? AdWidget(ad: addCtrl.bannerAd!)
                .height(Sizes.s50)
                .paddingOnly(bottom: Insets.i10)
                .width(MediaQuery.of(context).size.width)
                : Container()
                : Container(
                alignment: Alignment.bottomCenter,
                child: addCtrl.currentAd)
                .paddingSymmetric(
                vertical: Insets.i10, horizontal: Insets.i20)
                .width(MediaQuery.of(context).size.width)
      ],
    );
  }
}
