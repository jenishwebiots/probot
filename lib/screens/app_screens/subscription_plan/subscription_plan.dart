
import '../../../config.dart';


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
        body: Column(children: [
          Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                CommonSubscribeTitle(
                    subscribeModel:
                        SubscribeModel.fromJson(appArray.subscriptionPlan[0])),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonCircularIndicator(
                          percent: 1, title: appFonts.unlimitedChat),
                      const CommonCircularIndicator(
                          percent: 0.7, title: "18 images\nremaining"),
                      const CommonCircularIndicator(
                          percent: 0.5, title: "10 topics\nremaining")
                    ]).marginSymmetric(
                    horizontal: Insets.i20, vertical: Insets.i20),
                SubscriptionPlanCommonWidget().dottedLine(),
                SubscriptionPlanCommonWidget().noOfDaysLeftText("three"),

                    const LifeCycleLayout(),
                DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1,
                        dashLength: 3,
                        dashColor: appCtrl.appTheme.greyLight)
                    .marginSymmetric(horizontal: Insets.i15),
                Text(appFonts.noOfDaysLeft("three"),
                        style: AppCss.outfitMedium14
                            .textColor(appCtrl.appTheme.redColor))
                    .marginSymmetric(
                        horizontal: Insets.i15, vertical: Insets.i15),

                ButtonCommon(
                    onTap: () {},
                    title: appFonts.renewNow.tr,
                    margin: Insets.i15,
                    isGradient: false,
                    style: AppCss.outfitMedium16
                        .textColor(appCtrl.appTheme.primary),
                    color: appCtrl.appTheme.trans,
                    borderColor: appCtrl.appTheme.primary),
                const VSpace(Sizes.s15)

              ],
            )
                .subscribeExtension()
                .marginOnly(top: Insets.i25, bottom: Insets.i15),
            SubscriptionPlanCommonWidget().noteTextWidget()
          ],
        ).marginSymmetric(horizontal: Insets.i20));



  }
}
