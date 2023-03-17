import '../../../config.dart';

class Subscription extends StatelessWidget {
  final subscribeCtrl = Get.put(SubscriptionController());

  Subscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              title: appFonts.subscriptionPlan,
              actionIcon: eSvgAssets.currency,isAction: true,
              leadingOnTap: () => Get.back(),actionOnTap: ()=>subscribeCtrl.currencyListDialog(),),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ...subscribeCtrl.subscriptionLists
                    .asMap()
                    .entries
                    .map((e) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(e.value.icon!),
                                const HSpace(Sizes.s8),
                                /* Text("${e.value.planName!.tr.toUpperCase()} /",style: AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.primary),)*/
                                RichText(
                                    text: TextSpan(
                                        text:
                                            "${e.value.planName!.tr.toUpperCase()} / ",
                                        style: AppCss.outfitSemiBold14
                                            .textColor(
                                                appCtrl.appTheme.primary),
                                        children: <TextSpan>[
                                      TextSpan(
                                          text: e.value.type!.tr.toUpperCase(),
                                          style: AppCss.outfitMedium14
                                              .textColor(
                                                  appCtrl.appTheme.primary)),
                                    ]))
                              ],
                            ).paddingSymmetric(vertical: Insets.i15).decorated(color: Color.fromRGBO(53, 193, 255, 0.2),borderRadius: BorderRadius.only(topRight: Radius.circular(AppRadius.r10),topLeft: Radius.circular(AppRadius.r10))),
                            ...e.value.benefits!
                                .map((e) => Row(
                                      children: [
                                        Icon(Icons.circle,
                                            size: Sizes.s3,
                                            color: appCtrl.appTheme.lightText),
                                        const HSpace(Sizes.s8),
                                        Text(e.toString().tr,
                                            style: AppCss.outfitLight14
                                                .textColor(appCtrl
                                                    .appTheme.lightText)),
                                      ],
                                    ).marginSymmetric(
                                        horizontal: Insets.i20,
                                        vertical: Insets.i8))
                                .toList(),
                            const VSpace(Sizes.s10),
                            DottedLine(
                                    direction: Axis.horizontal,
                                    lineLength: double.infinity,
                                    lineThickness: 1,
                                    dashLength: 3,
                                    dashColor:
                                        appCtrl.appTheme.txt.withOpacity(.1))
                                .marginSymmetric(horizontal: Insets.i15),
                            const VSpace(Sizes.s12),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: "${appCtrl.priceSymbol}${(appCtrl.currencyVal * e.value.price!).toStringAsFixed(2)} / ",
                                          style: AppCss.outfitSemiBold18
                                              .textColor(appCtrl.appTheme.txt),
                                          children: <TextSpan>[
                                        TextSpan(
                                            text: e.value.priceTpe!.tr
                                                .toUpperCase(),
                                            style: AppCss.outfitMedium14
                                                .textColor(
                                                    appCtrl.appTheme.txt)),
                                      ])),
                                  Row(children: [
                                    Text(appFonts.payNow.tr,
                                        style: AppCss.outfitMedium14.textColor(
                                            appCtrl.appTheme.primary)),
                                    const HSpace(Sizes.s8),
                                    SvgPicture.asset(
                                      eSvgAssets.rightArrow,
                                      colorFilter: ColorFilter.mode(
                                          appCtrl.appTheme.primary,
                                          BlendMode.srcIn),
                                    )
                                  ])
                                ]).marginSymmetric(horizontal: Insets.i15),
                            const VSpace(Sizes.s20)
                          ],
                        )
                            .decorated(
                                color: appCtrl.appTheme.white,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.r10),  border: Border.all(
                    color: const Color.fromRGBO(53, 193, 255, 0.08)),
                    boxShadow: [
                      const BoxShadow(
                          color: Color.fromRGBO(53, 193, 255, 0.06),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ])
                    .marginOnly(bottom: Insets.i20))
                    .toList()
              ],
            ).marginSymmetric(vertical: Insets.i25, horizontal: Insets.i20),
          ));
    });
  }
}
