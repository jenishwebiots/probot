import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:probot/config.dart';

import 'layouts/quick_advisor_layout.dart';

class Home extends StatelessWidget {
  final homeCtrl = Get.put(HomeController());

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return CommonStream(
        child: Scaffold(
          key: homeCtrl.scaffoldKey,
          drawer: const CommonDrawer(),
          body: Stack(alignment: Alignment.bottomCenter, children: [
            SingleChildScrollView(
                child: Column(children: [
              HomeTopLayout(
                  onTap: () => homeCtrl.scaffoldKey.currentState!.openDrawer()),
              const DottedLines(),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VSpace(Sizes.s20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(appFonts.quickAdvice.tr,
                              style: AppCss.outfitSemiBold16
                                  .textColor(appCtrl.appTheme.txt)),
                          Text(appFonts.viewAll.tr,
                                  style: AppCss.outfitSemiBold12
                                      .textColor(appCtrl.appTheme.primary))
                              .inkWell(
                                  onTap: () =>
                                      Get.toNamed(routeName.quickAdvisor))
                        ]),
                    /* ...homeCtrl.homeOptionList.asMap().entries.map((e) {
                          return ((appCtrl.firebaseConfigModel!.isChatShow! &&
                                      e.key == 0) ||
                                  (appCtrl.firebaseConfigModel!
                                          .isImageGeneratorShow! &&
                                      e.key == 1) ||
                                  ((appCtrl.firebaseConfigModel!
                                          .isTextCompletionShow! &&
                                      e.key == 2)))
                              ? OptionCard(homeOptionModel: e.value).inkWell(
                                  onTap: () => homeCtrl.onOptionTap(e.value))
                              : Container();
                        }).toList(),
                        const VSpace(Sizes.s80),
                      ]).marginSymmetric(horizontal: Sizes.s20)
                ])),
                if (appCtrl.firebaseConfigModel!.isAddShow!)
                  appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!
                      ? (homeCtrl.bannerAd != null && homeCtrl.bannerAdIsLoaded)
                          ? AdWidget(ad: homeCtrl.bannerAd!)
                              .height(Sizes.s50)
                              .paddingOnly(bottom: Insets.i10)
                              .width(MediaQuery.of(context).size.width)
                          : Container()
                      : Align(
                    alignment: const Alignment(0, 1.0),
                    child: homeCtrl.currentAd,
                  ) .paddingSymmetric(vertical: Insets.i10,horizontal: Insets.i20,)
                      .width(MediaQuery.of(context).size.width)
              ]),
              backgroundColor: appCtrl.appTheme.bg1,
            );
          }
                        }).toList(),*/
                    const VSpace(Sizes.s18),
                    GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeCtrl.quickAdvisorLists.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 20,
                                childAspectRatio: 1,
                                mainAxisSpacing: 15,
                                mainAxisExtent: 105,
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return QuickAdvisorLayout(
                              data: homeCtrl.quickAdvisorLists[index]);
                        }),
                    const VSpace(Sizes.s80),
                  ]).marginSymmetric(horizontal: Sizes.s20)
            ])),
            if (appCtrl.firebaseConfigModel!.isAddShow!)
              if (homeCtrl.bannerAd != null)
                AdWidget(ad: homeCtrl.bannerAd!)
                    .height(Sizes.s50)
                    .paddingOnly(bottom: Insets.i10)
                    .width(MediaQuery.of(context).size.width)
          ]),
          backgroundColor: appCtrl.appTheme.bg1,
        ),
      );
    });
  }
}
