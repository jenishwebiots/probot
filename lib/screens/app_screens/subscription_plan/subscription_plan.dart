import 'package:percent_indicator/circular_percent_indicator.dart';

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
        body: Column(
          children: [
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
                    Column(children: [
                      CircularPercentIndicator(
                        radius: AppRadius.r28,
                        lineWidth: 2.5,
                        reverse: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        percent: 1,
                        center: SvgPicture.asset(
                          eSvgAssets.chat,
                          colorFilter: ColorFilter.mode(
                              appCtrl.appTheme.primary, BlendMode.srcIn),
                        ),
                        backgroundColor: appCtrl.appTheme.primaryLight1,
                        progressColor: appCtrl.appTheme.primary,
                      ),
                      const VSpace(Sizes.s8),
                      Text(
                        "Unlimited\nchat",
                        textAlign: TextAlign.center,
                        style: AppCss.outfitMedium14
                            .textColor(appCtrl.appTheme.txt),
                      )
                    ]),
                    Column(
                      children: [
                        CircularPercentIndicator(
                          radius: AppRadius.r28,
                          lineWidth: 2.5,
                          reverse: true,
                          circularStrokeCap: CircularStrokeCap.round,
                          percent: 0.7,
                          center: SvgPicture.asset(eSvgAssets.gallery,
                              colorFilter: ColorFilter.mode(
                                  appCtrl.appTheme.primary, BlendMode.srcIn)),
                          backgroundColor: appCtrl.appTheme.primaryLight1,
                          progressColor: appCtrl.appTheme.primary,
                        ),
                        const VSpace(Sizes.s8),
                        Text(
                          "18 images\nremaining",
                          textAlign: TextAlign.center,
                          style: AppCss.outfitMedium14
                              .textColor(appCtrl.appTheme.txt),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircularPercentIndicator(
                          radius: AppRadius.r28,
                          lineWidth: 3.0,
                          reverse: true,
                          circularStrokeCap: CircularStrokeCap.round,
                          percent: .5,
                          center: SvgPicture.asset(
                            eSvgAssets.content,
                            colorFilter: ColorFilter.mode(
                                appCtrl.appTheme.primary, BlendMode.srcIn),
                          ),
                          backgroundColor: appCtrl.appTheme.primaryLight1,
                          progressColor: appCtrl.appTheme.primary,
                        ),
                        const VSpace(Sizes.s8),
                        Text(
                          "10 topics\nremaining",
                          textAlign: TextAlign.center,
                          style: AppCss.outfitMedium14
                              .textColor(appCtrl.appTheme.txt),
                        )
                      ],
                    )
                  ],
                ).marginSymmetric(horizontal: Insets.i20, vertical: Insets.i20),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Note  :",
                    style: AppCss.outfitSemiBold12
                        .textColor(appCtrl.appTheme.lightText)),
                const HSpace(Sizes.s6),
                Expanded(
                    child: Text(
                        "*If you choose to upgrade your plan, the remaining images and content will be automatically adjusted to the new plan.",
                        style: AppCss.outfitSemiBold12
                            .textColor(appCtrl.appTheme.lightText).textHeight(1.5)))
              ],
            )
          ],
        ).marginSymmetric(horizontal: Insets.i20));
  }
}
