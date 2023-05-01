import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:intl/intl.dart';

import '../../../../config.dart';

class SubscribePlanUI extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapShot;
  final dynamic data;

  const SubscribePlanUI({Key? key, this.snapShot, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipSmoothRect(
          clipBehavior: Clip.hardEdge,
          child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: Insets.i8, horizontal: Insets.i5),
              decoration: BoxDecoration(
                  color: snapShot!.data!.docs[0]
                              .data()["subscriptionType"]
                              .toString()
                              .toLowerCase() ==
                          data["planType"].toString().toLowerCase()
                      ? appCtrl.appTheme.yellowColor
                      : appCtrl.appTheme.primaryLight,
                  border: Border.all(
                      color: snapShot!.data!.docs[0]
                                  .data()["subscriptionType"]
                                  .toString()
                                  .toLowerCase() ==
                              data["planType"].toString().toLowerCase()
                          ? appCtrl.appTheme.yellowColor
                          : appCtrl.appTheme.primaryLight1),
                  borderRadius:
                      SmoothBorderRadius(cornerRadius: 10, cornerSmoothing: 1)),
              child: Column(
                children: [
                  ClipSmoothRect(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Insets.i20, vertical: Insets.i15),
                        decoration: BoxDecoration(
                            color: appCtrl.appTheme.sameWhite,
                            borderRadius: const SmoothBorderRadius.only(
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
                            snapShot!.data!.docs[0]
                                        .data()["subscriptionType"]
                                        .toString()
                                        .toLowerCase() ==
                                    data["planType"].toString().toLowerCase()
                                ? Text("PURCHASED",
                                    style: AppCss.outfitMedium10
                                        .textColor(appCtrl.appTheme.lightText))
                                : Text(data["planType"],
                                    style: AppCss.outfitMedium14
                                        .textColor(appCtrl.appTheme.primary)),
                            const VSpace(Sizes.s10),
                            Text(
                                appCtrl.priceSymbol +
                                    (appCtrl.currencyVal * data["price"])
                                        .toStringAsFixed(0)
                                        .toString(),
                                style: AppCss.outfitBold18
                                    .textColor(appCtrl.appTheme.txt)),
                            const VSpace(Sizes.s5),
                            Text("/${data["type"]}",
                                style: AppCss.outfitRegular12
                                    .textColor(appCtrl.appTheme.lightText)),
                          ],
                        )),
                  ),
                  (snapShot!.data!.docs[0]
                              .data()["subscriptionType"]
                              .toString()
                              .toLowerCase() ==
                          data["planType"].toString().toLowerCase())
                      ? Column(
                          children: [
                            Text("Renews",
                                textAlign: TextAlign.center,
                                style: AppCss.outfitMedium12
                                    .textColor(appCtrl.appTheme.sameWhite)
                                    .textHeight(1.2)),
                            const VSpace(Sizes.s5),
                            Text(
                                DateFormat("dd/MM/yyyy").format(DateTime.parse(
                                    snapShot!.data!.docs[0]["expiryDate"]
                                        .toDate()
                                        .toString())),
                                textAlign: TextAlign.center,
                                style: AppCss.outfitBold12
                                    .textColor(appCtrl.appTheme.sameWhite)
                                    .textHeight(1.2))
                          ],
                        ).marginSymmetric(vertical: Insets.i6)
                      : Text(data["title"].toString().replaceAll("-", "\n"),
                              textAlign: TextAlign.center,
                              style: AppCss.outfitMedium12
                                  .textColor(appCtrl.appTheme.primary)
                                  .textHeight(1.2))
                          .paddingSymmetric(vertical: Insets.i8)
                ],
              )),
        ),
        if (snapShot!.data!.docs[0]
                .data()["subscriptionType"]
                .toString()
                .toLowerCase() ==
            data["planType"].toString().toLowerCase())
          SvgPicture.asset(
            eSvgAssets.crown,
            colorFilter:
                ColorFilter.mode(appCtrl.appTheme.sameWhite, BlendMode.srcIn),
          ).paddingAll(Insets.i8).decorated(
              color: appCtrl.appTheme.yellowColor, shape: BoxShape.circle)
      ],
    ).inkWell(onTap: () => Get.toNamed(routeName.viewSubscription));
  }
}
