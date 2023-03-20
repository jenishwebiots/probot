import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:probot/config.dart';
import 'package:probot/env.dart';

class Home extends StatelessWidget {
  final homeCtrl = Get.put(HomeController());

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
          key: homeCtrl.scaffoldKey,
          drawer: const CommonDrawer(),
          backgroundColor: appCtrl.appTheme.bg1,
          body: Stack(alignment: Alignment.bottomCenter, children: [
            NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) =>
                        [const HomeSliverAppBar()],
                body: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const DottedLines(),
                  const VSpace(Sizes.s20),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appFonts.chooseOption.tr,
                            style: AppCss.outfitRegular16
                                .textColor(appCtrl.appTheme.lightText)
                                .textHeight(1.3)
                                .letterSpace(.3)),
                        const VSpace(Sizes.s20),
                        ...homeCtrl.homeOptionList.asMap().entries.map((e) {
                          return ((environment["isChatShow"] && e.key == 0) ||
                                  (environment["isImageGeneratorShow"] &&
                                      e.key == 1) ||
                                  ((environment["isTextCompletionShow"] &&
                                      e.key == 2)))
                              ? OptionCard(homeOptionModel: e.value).inkWell(
                                  onTap: () => homeCtrl.onOptionTap(e.value))
                              : Container();
                        }).toList(),
                      ]).marginSymmetric(horizontal: Sizes.s20)
                ]))),
            if (homeCtrl.bannerAd != null)
              AdWidget(ad: homeCtrl.bannerAd!)
                  .height(Sizes.s50)
                  .width(MediaQuery.of(context).size.width)
          ]));
    });
  }
}
