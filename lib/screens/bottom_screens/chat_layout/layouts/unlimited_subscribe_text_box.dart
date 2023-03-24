import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../config.dart';

class UnlimitedSubscribeTextBox extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapShot;

  const UnlimitedSubscribeTextBox({Key? key, this.snapShot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return Column(
        children: [
          if (snapShot!.data!.docs[0].data()["subscriptionType"] != "yearly")
            if (appCtrl.envConfig["chatTextCount"] != 0)
              Column(
                children: [
                  Text(
                      appFonts
                          .thereAreAwardLeft(
                              appCtrl.envConfig["chatTextCount"].toString())
                          .tr,
                      style: AppCss.outfitSemiBold14
                          .textColor(appCtrl.appTheme.lightText)),
                  const VSpace(Sizes.s10),
                ],
              ),
          if (snapShot!.data!.docs[0].data()["subscriptionType"] != "unlimited")
            if (appCtrl.envConfig["chatTextCount"] == 0)
              LimitOverLayout(onTap: () => appCtrl.showRewardedAd()),
          if (appCtrl.envConfig["chatTextCount"] != 0)
            const ChatLayoutTextBox()
        ],
      );
    });
  }
}
