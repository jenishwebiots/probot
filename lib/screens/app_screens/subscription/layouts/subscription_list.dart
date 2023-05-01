import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_squircle/figma_squircle.dart';

import '../../../../config.dart';

class SubscriptionList extends StatelessWidget {
  const SubscriptionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (subscribeCtrl) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("plans")
            .orderBy("price", descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("userSubscribe")
                    .where("email", isEqualTo: appCtrl.storage.read("userName"))
                    .limit(1)
                    .snapshots(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...snapshot.data!
                            .docs
                            .asMap()
                            .entries
                            .map((e) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipSmoothRect(
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: Insets.i8,
                                        horizontal: Insets.i5),
                                    decoration: BoxDecoration(
                                        color: subscribeCtrl.selectedPlan ==
                                            e.key
                                            ? appCtrl.appTheme.primary
                                            : appCtrl.appTheme.primaryLight,
                                        border: Border.all(
                                            color: subscribeCtrl.selectedPlan ==
                                                e.key
                                                ? appCtrl.appTheme.primary
                                                : appCtrl.appTheme
                                                .primaryLight1),
                                        borderRadius: SmoothBorderRadius(
                                            cornerRadius: 10,
                                            cornerSmoothing: 1)),
                                    child: Column(
                                      children: [
                                        ClipSmoothRect(
                                          child: Container(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: Insets.i25,
                                                  vertical: Insets.i15),
                                              decoration: BoxDecoration(
                                                  color: e.key ==
                                                      subscribeCtrl.selectedPlan
                                                      ? appCtrl.appTheme
                                                      .primaryLight2
                                                      : appCtrl.appTheme
                                                      .sameWhite,
                                                  borderRadius:
                                                  const SmoothBorderRadius.only(
                                                      topLeft: SmoothRadius(
                                                        cornerRadius: 10,
                                                        cornerSmoothing: 1,
                                                      ),
                                                      topRight: SmoothRadius(
                                                        cornerRadius: 10,
                                                        cornerSmoothing: 1,
                                                      ))),
                                              child: Column(
                                                children: [
                                                  Text(e.value
                                                      .data()["planType"],
                                                      style: AppCss
                                                          .outfitMedium14
                                                          .textColor(appCtrl
                                                          .appTheme.primary)),
                                                  const VSpace(Sizes.s10),
                                                  Text(
                                                      appCtrl.priceSymbol +
                                                          (appCtrl.currencyVal *
                                                              e.value
                                                                  .data()["price"])
                                                              .toStringAsFixed(
                                                              0)
                                                              .toString(),
                                                      style: AppCss.outfitBold18
                                                          .textColor(
                                                          appCtrl.appTheme
                                                              .txt)),
                                                  const VSpace(Sizes.s5),
                                                  Text("/${e.value
                                                      .data()["type"]}",
                                                      style: AppCss
                                                          .outfitRegular12
                                                          .textColor(appCtrl
                                                          .appTheme.lightText)),
                                                ],
                                              )),
                                        ),
                                        Text(
                                            e.value
                                                .data()["title"]
                                                .toString()
                                                .replaceAll("-", "\n"),
                                            textAlign: TextAlign.center,
                                            style: AppCss.outfitMedium12
                                                .textColor(e.key ==
                                                subscribeCtrl.selectedPlan
                                                ? appCtrl.appTheme.sameWhite
                                                : appCtrl.appTheme.primary)
                                                .textHeight(1.2))
                                            .paddingSymmetric(
                                            vertical: Insets.i8)
                                      ],
                                    )),
                              ),
                              if (e.key == subscribeCtrl.selectedPlan)
                                SvgPicture.asset(eSvgAssets.singleTick)
                                    .paddingAll(Insets.i8)
                                    .decorated(
                                    color: appCtrl.appTheme.primary,
                                    shape: BoxShape.circle)
                            ],
                          ).inkWell(onTap: () {
                            subscribeCtrl.selectedPlan = e.key;
                            subscribeCtrl.selectedPrice =
                            e.value.data()["price"];
                            subscribeCtrl.subscribeModel =
                                SubscribeModel.fromJson(e.value.data());
                            subscribeCtrl.update();
                          });
                        }).toList()
                      ],
                    ).marginSymmetric(horizontal: Insets.i10);
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...snapshot.data!
                            .docs
                            .asMap()
                            .entries
                            .map((e) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipSmoothRect(
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: Insets.i8,
                                        horizontal: Insets.i5),
                                    decoration: BoxDecoration(
                                        color: subscribeCtrl.selectedPlan ==
                                            e.key
                                            ? appCtrl.appTheme.primary
                                            : appCtrl.appTheme.primaryLight,
                                        border: Border.all(
                                            color: subscribeCtrl.selectedPlan ==
                                                e.key
                                                ? appCtrl.appTheme.primary
                                                : appCtrl.appTheme
                                                .primaryLight1),
                                        borderRadius: SmoothBorderRadius(
                                            cornerRadius: 10,
                                            cornerSmoothing: 1)),
                                    child: Column(
                                      children: [
                                        ClipSmoothRect(
                                          child: Container(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: Insets.i28,
                                                  vertical: Insets.i15),
                                              decoration: BoxDecoration(
                                                  color: e.key ==
                                                      subscribeCtrl.selectedPlan
                                                      ? appCtrl.appTheme
                                                      .primaryLight2
                                                      : appCtrl.appTheme
                                                      .sameWhite,
                                                  borderRadius:
                                                  const SmoothBorderRadius.only(
                                                      topLeft: SmoothRadius(
                                                        cornerRadius: 10,
                                                        cornerSmoothing: 1,
                                                      ),
                                                      topRight: SmoothRadius(
                                                        cornerRadius: 10,
                                                        cornerSmoothing: 1,
                                                      ))),
                                              child: Column(
                                                children: [
                                                  Text(e.value
                                                      .data()["planType"],
                                                      style: AppCss
                                                          .outfitMedium14
                                                          .textColor(appCtrl
                                                          .appTheme.primary)),
                                                  const VSpace(Sizes.s10),
                                                  Text(
                                                      appCtrl.priceSymbol +
                                                          (appCtrl.currencyVal *
                                                              e.value
                                                                  .data()["price"])
                                                              .toStringAsFixed(
                                                              0)
                                                              .toString(),
                                                      style: AppCss.outfitBold18
                                                          .textColor(
                                                          appCtrl.appTheme
                                                              .txt)),
                                                  const VSpace(Sizes.s5),
                                                  Text("/${e.value
                                                      .data()["type"]}",
                                                      style: AppCss
                                                          .outfitRegular12
                                                          .textColor(appCtrl
                                                          .appTheme.lightText)),
                                                ],
                                              )),
                                        ),
                                        Text(
                                            e.value
                                                .data()["title"]
                                                .toString()
                                                .replaceAll("-", "\n"),
                                            textAlign: TextAlign.center,
                                            style: AppCss.outfitMedium12
                                                .textColor(e.key ==
                                                subscribeCtrl.selectedPlan
                                                ? appCtrl.appTheme.sameWhite
                                                : appCtrl.appTheme.primary)
                                                .textHeight(1.2))
                                            .paddingSymmetric(
                                            vertical: Insets.i8)
                                      ],
                                    )),
                              ),
                              if (e.key == subscribeCtrl.selectedPlan)
                                SvgPicture.asset(eSvgAssets.singleTick)
                                    .paddingAll(Insets.i8)
                                    .decorated(
                                    color: appCtrl.appTheme.primary,
                                    shape: BoxShape.circle)
                            ],
                          ).inkWell(onTap: () {
                            subscribeCtrl.selectedPlan = e.key;
                            subscribeCtrl.selectedPrice =
                            e.value.data()["price"];
                            subscribeCtrl.subscribeModel =
                                SubscribeModel.fromJson(e.value.data());
                            subscribeCtrl.update();
                          });
                        }).toList()
                      ],
                    ).marginSymmetric(horizontal: Insets.i10);
                  }
                }
            );
          } else {
            return Container();
          }
        },
      );
    });
  }
}
