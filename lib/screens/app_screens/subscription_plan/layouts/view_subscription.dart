import "package:cloud_firestore/cloud_firestore.dart";
import "package:intl/intl.dart";

import "../../../../config.dart";

class ViewSubscription extends StatelessWidget {
  const ViewSubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (subscribeCtrl) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              title: appFonts.subscriptionPlan,
              actionIcon: eSvgAssets.currency,
              isAction: true,
              leadingOnTap: () => Get.back(),
              actionOnTap: () => subscribeCtrl.currencyListDialog()),
          body: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("plans")
                        .orderBy("price", descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container();
                      } else if (!snapshot.hasData) {
                        return Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        appCtrl.appTheme.primary)))
                            .height(MediaQuery.of(context).size.height);
                      } else {
                        return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("userSubscribe")
                                .where("email",
                                    isEqualTo: appCtrl.storage.read("userName"))
                                .limit(1)
                                .snapshots(),
                            builder: (context, snapShot) {
                              if (snapShot.hasData) {
                                return Column(children: [
                                  ...snapshot.data!.docs
                                      .asMap()
                                      .entries
                                      .map((e) {
                                    SubscribeModel subscribe =
                                        SubscribeModel.fromJson(e.value.data());

                                    return Column(
                                      children: [
                                        CommonSubscribeTitle(
                                            subscribeModel: subscribe,
                                            isActivePlan: snapShot.data!.docs[0]
                                                    .data()["subscriptionType"]
                                                    .toString()
                                                    .toLowerCase() ==
                                                e.value
                                                    .data()["planType"]
                                                    .toString()
                                                    .toLowerCase()),
                                        const VSpace(Sizes.s20),
                                        snapShot.data!.docs[0]
                                                    .data()["subscriptionType"]
                                                    .toString()
                                                    .toLowerCase() ==
                                                e.value
                                                    .data()["planType"]
                                                    .toString()
                                                    .toLowerCase()
                                            ? Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Paid amount :",
                                                          style: AppCss
                                                              .outfitRegular12
                                                              .textColor(appCtrl
                                                                  .appTheme
                                                                  .lightText)),
                                                      Text(
                                                          "${appCtrl.priceSymbol}${(appCtrl.currencyVal * e.value.data()["price"]).toStringAsFixed(0)}",
                                                          style: AppCss
                                                              .outfitSemiBold12
                                                              .textColor(appCtrl
                                                                  .appTheme
                                                                  .txt))
                                                    ],
                                                  ),
                                                  const VSpace(Sizes.s20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Including :",
                                                          style: AppCss
                                                              .outfitRegular12
                                                              .textColor(appCtrl
                                                                  .appTheme
                                                                  .lightText)),
                                                      Text(
                                                          "Unlimited chat, images, & content",
                                                          style: AppCss
                                                              .outfitSemiBold12
                                                              .textColor(appCtrl
                                                                  .appTheme
                                                                  .txt))
                                                    ],
                                                  ),
                                                  const VSpace(Sizes.s40),
                                                  DottedLine(
                                                      direction:
                                                          Axis.horizontal,
                                                      lineLength:
                                                          double.infinity,
                                                      lineThickness: 1,
                                                      dashLength: 3,
                                                      dashColor: appCtrl
                                                          .appTheme.txt
                                                          .withOpacity(.1)),
                                                  const VSpace(Sizes.s15),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Expiry Date :",
                                                          style: AppCss
                                                              .outfitRegular12
                                                              .textColor(appCtrl
                                                                  .appTheme
                                                                  .redColor)),
                                                      Text(
                                                          DateFormat(
                                                                  "dd/MM/yyyy")
                                                              .format(DateTime
                                                                  .parse(snapShot
                                                                      .data!
                                                                      .docs[0][
                                                                          "expiryDate"]
                                                                      .toDate()
                                                                      .toString())),
                                                          style: AppCss
                                                              .outfitSemiBold12
                                                              .textColor(appCtrl
                                                                  .appTheme
                                                                  .redColor))
                                                    ],
                                                  )
                                                ],
                                              ).marginSymmetric(
                                                horizontal: Insets.i15)
                                            : Column(
                                                children: [
                                                  Text(
                                                    "${appCtrl.priceSymbol}${(appCtrl.currencyVal * subscribe.price!).toStringAsFixed(2)} only/- ",
                                                    style: AppCss
                                                        .outfitSemiBold18
                                                        .textColor(appCtrl
                                                            .appTheme.primary),
                                                  ).marginSymmetric(
                                                      horizontal: Insets.i15),
                                                  const VSpace(Sizes.s20),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.circle,
                                                          size: Sizes.s3,
                                                          color: appCtrl
                                                              .appTheme.txt),
                                                      const HSpace(Sizes.s8),
                                                      Expanded(
                                                        child: Text(
                                                            "Unlimited chat for a month",
                                                            style: AppCss
                                                                .outfitLight14
                                                                .textColor(
                                                                    appCtrl
                                                                        .appTheme
                                                                        .txt)),
                                                      ),
                                                    ],
                                                  ),
                                                  const VSpace(Sizes.s15),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.circle,
                                                          size: Sizes.s3,
                                                          color: appCtrl
                                                              .appTheme.txt),
                                                      const HSpace(Sizes.s8),
                                                      Expanded(
                                                        child: Text(
                                                            "Unlimited Image generating for a month",
                                                            style: AppCss
                                                                .outfitLight14
                                                                .textColor(
                                                                    appCtrl
                                                                        .appTheme
                                                                        .txt)),
                                                      ),
                                                    ],
                                                  ),
                                                  const VSpace(Sizes.s15),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.circle,
                                                          size: Sizes.s3,
                                                          color: appCtrl
                                                              .appTheme.txt),
                                                      const HSpace(Sizes.s8),
                                                      Expanded(
                                                        child: Text(
                                                            "Unlimited content writing for a month",
                                                            style: AppCss
                                                                .outfitLight14
                                                                .textColor(
                                                                    appCtrl
                                                                        .appTheme
                                                                        .txt)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ).marginSymmetric(
                                                horizontal: Insets.i15),
                                        const VSpace(Sizes.s20),
                                        if (snapShot.data!.docs[0]
                                                .data()["subscriptionType"]
                                                .toString()
                                                .toLowerCase() !=
                                            e.value
                                                .data()["planType"]
                                                .toString()
                                                .toLowerCase())
                                          ButtonCommon(
                                              title: "Select this Plan",
                                              isGradient: false,
                                              margin: 15,
                                              onTap: () {
                                                subscribeCtrl.selectedPrice =
                                                    e.value.data()["price"];
                                                subscribeCtrl.subscribeModel =
                                                    SubscribeModel.fromJson(
                                                        e.value.data());
                                                subscribeCtrl.paymentDialog(
                                                    subscribeCtrl.selectedPrice
                                                        .toString(),
                                                    subscribeCtrl
                                                        .subscribeModel);
                                              },
                                              style: AppCss.outfitRegular18
                                                  .textColor(
                                                      appCtrl.appTheme.primary)
                                                  .letterSpace(.4),
                                              color: appCtrl.appTheme.sameWhite,
                                              borderColor:
                                                  appCtrl.appTheme.primary),
                                        const VSpace(Sizes.s20),
                                      ],
                                    ).decorated(
                                        color: appCtrl.appTheme.white,
                                        borderRadius: BorderRadius.circular(
                                            AppRadius.r10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: appCtrl.isTheme
                                                  ? appCtrl.appTheme.trans
                                                  : appCtrl.appTheme.primary
                                                      .withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 4)
                                        ]).marginOnly(bottom: Insets.i20);
                                  }).toList()
                                ]);
                              } else {
                                return Container();
                              }
                            });
                      }
                    })
              ],
            ).marginSymmetric(vertical: Insets.i25, horizontal: Insets.i20),
          ));
    });
  }
}
