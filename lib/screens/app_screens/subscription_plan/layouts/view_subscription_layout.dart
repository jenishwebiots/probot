import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../../config.dart';

class ViewSubscriptionLayout extends StatelessWidget {
  final SubscribeModel? subscribe;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapShot;
  final dynamic data;
final GestureTapCallback? onTap;
  const ViewSubscriptionLayout(
      {Key? key, this.subscribe, this.snapShot, this.data,this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonSubscribeTitle(
            subscribeModel: subscribe,
            isActivePlan: snapShot!.data!.docs[0]
                    .data()["subscriptionType"]
                    .toString()
                    .toLowerCase() ==
                data["planType"].toString().toLowerCase()),
        const VSpace(Sizes.s20),
        snapShot!.data!.docs[0]
                    .data()["subscriptionType"]
                    .toString()
                    .toLowerCase() ==
                data["planType"].toString().toLowerCase()
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Paid amount :",
                          style: AppCss.outfitRegular12
                              .textColor(appCtrl.appTheme.lightText)),
                      Text(
                          "${appCtrl.priceSymbol}${(appCtrl.currencyVal * data["price"]).toStringAsFixed(0)}",
                          style: AppCss.outfitSemiBold12
                              .textColor(appCtrl.appTheme.txt))
                    ],
                  ),
                  const VSpace(Sizes.s20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Including :",
                          style: AppCss.outfitRegular12
                              .textColor(appCtrl.appTheme.lightText)),
                      Text("Unlimited chat, images, & content",
                          style: AppCss.outfitSemiBold12
                              .textColor(appCtrl.appTheme.txt))
                    ],
                  ),
                  const VSpace(Sizes.s40),
                  DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1,
                      dashLength: 3,
                      dashColor: appCtrl.appTheme.txt.withOpacity(.1)),
                  const VSpace(Sizes.s15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Expiry Date :",
                            style: AppCss.outfitRegular12
                                .textColor(appCtrl.appTheme.redColor)),
                        Text(
                            DateFormat("dd/MM/yyyy").format(DateTime.parse(
                                snapShot!.data!.docs[0]["expiryDate"]
                                    .toDate()
                                    .toString())),
                            style: AppCss.outfitSemiBold12
                                .textColor(appCtrl.appTheme.redColor))
                      ])
                ],
              ).marginSymmetric(horizontal: Insets.i15)
            : Column(
                children: [
                  Text(
                    "${appCtrl.priceSymbol}${(appCtrl.currencyVal * subscribe!.price!).toStringAsFixed(2)} only/- ",
                    style: AppCss.outfitSemiBold18
                        .textColor(appCtrl.appTheme.primary),
                  ).marginSymmetric(horizontal: Insets.i15),
                  const VSpace(Sizes.s20),
                  Row(
                    children: [
                      Icon(Icons.circle,
                          size: Sizes.s3, color: appCtrl.appTheme.txt),
                      const HSpace(Sizes.s8),
                      Expanded(
                        child: Text("Unlimited chat for a month",
                            style: AppCss.outfitLight14
                                .textColor(appCtrl.appTheme.txt)),
                      ),
                    ],
                  ),
                  const VSpace(Sizes.s15),
                  Row(
                    children: [
                      Icon(Icons.circle,
                          size: Sizes.s3, color: appCtrl.appTheme.txt),
                      const HSpace(Sizes.s8),
                      Expanded(
                        child: Text("Unlimited Image generating for a month",
                            style: AppCss.outfitLight14
                                .textColor(appCtrl.appTheme.txt)),
                      ),
                    ],
                  ),
                  const VSpace(Sizes.s15),
                  Row(
                    children: [
                      Icon(Icons.circle,
                          size: Sizes.s3, color: appCtrl.appTheme.txt),
                      const HSpace(Sizes.s8),
                      Expanded(
                        child: Text("Unlimited content writing for a month",
                            style: AppCss.outfitLight14
                                .textColor(appCtrl.appTheme.txt)),
                      ),
                    ],
                  ),
                ],
              ).marginSymmetric(horizontal: Insets.i15),
        const VSpace(Sizes.s20),
        if (snapShot!.data!.docs[0]
                .data()["subscriptionType"]
                .toString()
                .toLowerCase() !=
            data["planType"].toString().toLowerCase())
          ButtonCommon(
              title: "Select this Plan",
              isGradient: false,
              margin: 15,
              onTap: onTap,
              style: AppCss.outfitRegular18
                  .textColor(appCtrl.appTheme.primary)
                  .letterSpace(.4),
              color: appCtrl.appTheme.sameWhite,
              borderColor: appCtrl.appTheme.primary),
        const VSpace(Sizes.s20),
      ],
    );
  }
}
