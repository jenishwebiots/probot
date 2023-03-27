
import '../../../../config.dart';

class SubscribeTextBox extends StatelessWidget {

  const SubscribeTextBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return Column(
        children: [
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
          if (appCtrl.envConfig["chatTextCount"] == 0)
            LimitOverLayout(onTap: () => appCtrl.showRewardedAd()),
          if (appCtrl.envConfig["chatTextCount"] != 0)
            const ChatLayoutTextBox()
        ],
      );
    });
  }
}
