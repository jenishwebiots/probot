import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:probot/config.dart';
import 'package:probot/models/category_access_model.dart';

import 'layouts/quick_advisor_layout.dart';

class Home extends StatelessWidget {
  final homeCtrl = Get.put(HomeController());

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      appCtrl.commonThemeChange();
      return CommonStream(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: homeCtrl.scaffoldKey,
              drawer: const CommonDrawer(),
              body: Stack(alignment: Alignment.bottomCenter, children: [
                Column(children: [
                  HomeTopLayout(
                      onTap: () =>
                          homeCtrl.scaffoldKey.currentState!.openDrawer()),
                  const DottedLines(),
                  if (appCtrl.isSubscribe == false)
                    Image.asset(eImageAssets.homeBanner)
                        .padding(horizontal: Insets.i20, top: Insets.i15),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
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
                        const VSpace(Sizes.s18),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("categoryAccess")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                appCtrl.categoryAccessModel =
                                    CategoryAccessModel.fromJson(
                                        snapshot.data!.docs[0].data());
                                appCtrl.storage.write(session.categoryConfig,
                                    appCtrl.categoryAccessModel);
                                homeCtrl.getQuickData();
                                homeCtrl.getFavData();

                                return GetBuilder<QuickAdvisorController>(
                                    builder: (quickCtrl) {
                                  return quickCtrl.favoriteDataList.isNotEmpty
                                      ? GridView.builder(
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: homeCtrl.quickAdvisorCtrl
                                              .favoriteDataList.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: 20,
                                                  childAspectRatio: 1,
                                                  mainAxisSpacing: 15,
                                                  mainAxisExtent: 105,
                                                  crossAxisCount: 3),
                                          itemBuilder: (context, index) {
                                            return QuickAdvisorLayout(
                                                index: index,
                                                isFavorite: true,
                                                selectIndex: homeCtrl
                                                    .quickAdvisorCtrl
                                                    .selectedIndexRemove,
                                                data: homeCtrl.quickAdvisorCtrl
                                                    .favoriteDataList[index],
                                                onTap: () => homeCtrl
                                                    .quickAdvisorCtrl
                                                    .onTapRemoveFavorite(
                                                        index));
                                          })
                                      : GridView.builder(
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              homeCtrl.quickAdvisorLists.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: 20,
                                                  childAspectRatio: 1,
                                                  mainAxisSpacing: 15,
                                                  mainAxisExtent: 105,
                                                  crossAxisCount: 3),
                                          itemBuilder: (context, index) {
                                            return QuickAdvisorLayout(
                                                data: homeCtrl
                                                    .quickAdvisorLists[index]);
                                          });
                                });
                              } else {
                                return Container();
                              }
                            }),
                        const VSpace(Sizes.s50)
                      ]).marginSymmetric(horizontal: Sizes.s20)))
                ]),
                /* if (!appCtrl.isSubscribe)
              if (appCtrl.firebaseConfigModel!.isAddShow!)
                appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!
                    ? (homeCtrl.bannerAd != null && homeCtrl.bannerAdIsLoaded)
                        ? AdWidget(ad: homeCtrl.bannerAd!)
                            .height(Sizes.s50)
                            .paddingOnly(bottom: Insets.i10)
                            .width(MediaQuery.of(context).size.width)
                        : Container()
                    : Container(
                        alignment: Alignment.bottomCenter,
                        child: homeCtrl.currentAd,
                      )
                        .paddingSymmetric(
                          vertical: Insets.i15,
                          horizontal: Insets.i20,
                        )
                        .width(MediaQuery.of(context).size.width),*/
                AdCommonLayout(bannerAdIsLoaded: homeCtrl.bannerAdIsLoaded,bannerAd: homeCtrl.bannerAd,currentAd: homeCtrl.currentAd),
              ]),
              backgroundColor: appCtrl.appTheme.bg1));
    });
  }
}
