import "package:cloud_firestore/cloud_firestore.dart";
import "package:probot/screens/app_screens/subscription_plan/layouts/view_subscription_layout.dart";

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

                                    return ViewSubscriptionLayout(
                                      data: e.value.data(),
                                      onTap: () {
                                        subscribeCtrl.selectedPrice =
                                            e.value.data()["price"];
                                        subscribeCtrl.subscribeModel =
                                            SubscribeModel.fromJson(
                                                e.value.data());
                                        subscribeCtrl.paymentDialog(
                                            subscribeCtrl.selectedPrice
                                                .toString(),
                                            subscribeCtrl.subscribeModel);
                                      },
                                      snapShot: snapShot,
                                      subscribe: subscribe,
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
