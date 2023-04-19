import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../config.dart';


DateTime? _myTime;
class SubscriptionPlan extends StatelessWidget {
  const SubscriptionPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appCtrl.appTheme.bg1,
        appBar: AppAppBarCommon(
            title: appFonts.subscriptionPlan,
            actionIcon: eSvgAssets.currency,
            leadingOnTap: () => Get.back()),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("userSubscribe")
                .where("email", isEqualTo: appCtrl.storage.read("userName"))
                .limit(1)
                .snapshots(),
            builder: (context, snapshot) {

              if (snapshot.hasData) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("subscriptionPlan")
                        .where("type",
                            isEqualTo: snapshot.data!.docs[0]
                                ["subscriptionType"])
                        .limit(1)
                        .snapshots(),
                    builder: (context, snapshotData) {
                      if (snapshotData.hasData) {
                        SubscribeModel subscribeModel = SubscribeModel.fromJson(
                            snapshotData.data!.docs[0].data());
                        log("COUNT : ${appCtrl.envConfig}");
                        bool isExpiry = false;
                        DateTime dt1 = DateTime.parse(snapshot
                            .data!.docs[0]["expiryDate"]
                            .toDate()
                            .toString());
                        _myTime = DateTime.now();
                        if (dt1.isAfter(_myTime!)) {
                          isExpiry = true;
                        } else {
                          isExpiry = false;
                        }
                        return Column(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonSubscribeTitle(
                                    subscribeModel: subscribeModel),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonCircularIndicator(
                                          percent: double.parse((int.parse(
                                                      snapshot.data!.docs[0]
                                                          ["chatCount"]) /
                                                  int.parse(appCtrl.envConfig[
                                                          "chatTextCount"]
                                                      .toString()) /
                                                  100)
                                              .toStringAsFixed(2)),
                                          title:
                                              "${snapshot.data!.docs[0]["chatCount"]} chat\nremaining"),
                                      CommonCircularIndicator(
                                          percent: double.parse((int.parse(
                                                      snapshot.data!.docs[0]
                                                          ["imageCount"]) /
                                                  int.parse(appCtrl
                                                      .envConfig["imageCount"]
                                                      .toString()) /
                                                  100)
                                              .toStringAsFixed(2)),
                                          title:
                                              "${snapshot.data!.docs[0]["imageCount"]} images\nremaining"),
                                      CommonCircularIndicator(
                                          percent: (int.parse(
                                                  snapshot.data!.docs[0]
                                                      ["textCompletionCount"]) /
                                              int.parse(appCtrl.envConfig[
                                                      "textCompletionCount"]
                                                  .toString())),
                                          title:
                                              "${snapshot.data!.docs[0]["textCompletionCount"]} topics\nremaining")
                                    ]).marginSymmetric(
                                    horizontal: Insets.i20,
                                    vertical: Insets.i20),
                                SubscriptionPlanCommonWidget().dottedLine(),
                                isExpiry ?
                                  SubscriptionPlanCommonWidget().noOfDaysLeftText(
                                      "Your Plan Expire on ${DateFormat("dd/MM/yyyy hh:mm aa").format(DateTime.parse(snapshot.data!.docs[0]["expiryDate"].toDate().toString()))}"):ButtonCommon(
                                    onTap: () =>Get.toNamed(routeName.subscriptionPlanList),
                                    title: appFonts.renewNow.tr,
                                    margin: Insets.i15,
                                    isGradient: false,
                                    style: AppCss.outfitMedium16
                                        .textColor(appCtrl.appTheme.primary),
                                    color: appCtrl.appTheme.trans,
                                    borderColor: appCtrl.appTheme.primary),
                                const VSpace(Sizes.s15),
                                const VSpace(Sizes.s15)
                              ],
                            ).subscribeExtension().marginOnly(
                                top: Insets.i25, bottom: Insets.i15),
                          ],
                        ).marginSymmetric(horizontal: Insets.i20);
                      } else {
                        return Container();
                      }
                    });
              } else {
                return Container();
              }
            }));
  }
}

