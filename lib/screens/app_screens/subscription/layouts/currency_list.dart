import 'dart:developer';

import 'package:probot/screens/app_screens/subscription/layouts/currency_radio.dart';

import '../../../../config.dart';

class CurrencyList extends StatelessWidget {
  const CurrencyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (subscribeCtrl) {
      return Material(
        color: appCtrl.appTheme.trans,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appFonts.changeCurrency.tr,
                        style: AppCss.outfitblack20
                            .textColor(appCtrl.appTheme.txt)
                            .textDecoration(TextDecoration.none))
                    .paddingSymmetric(horizontal: Insets.i20),
                InkWell(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      eSvgAssets.cancel,
                      height: Sizes.s24,
                    ))
              ],
            ).paddingAll(Insets.i20),
            DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1,
                dashLength: 3,
                dashColor: appCtrl.appTheme.txt.withOpacity(.1)),
            const VSpace(Sizes.s25),
            ...appArray.currencyList
                .asMap()
                .entries
                .map((e) => Column(
                      children: [
                        ListTile(
                          trailing: CurrencyRadioButton(
                              data: e.value,
                              selectIndex: subscribeCtrl.selectIndex,
                              index: e.key,
                              onTap: () async {
                                log(" e.value : ${ e.value}");
                                appCtrl.priceSymbol =
                                    e.value["symbol"].toString();
                                subscribeCtrl.selectIndex = e.key;
                                appCtrl.currency =
                                    await appCtrl.storage.read("currency");
                                await appCtrl.storage
                                    .write("currency", e.value);
                                if (appCtrl.currency != e.value) {
                                  appCtrl.currencyVal = double.parse(appCtrl
                                      .currency[e.value["code"]]
                                      .toString());

                                  await appCtrl.storage
                                      .write("currencyCode", appCtrl.currency);

                                  appCtrl.update();
                                  subscribeCtrl.update();

                                  Get.forceAppUpdate();
                                }
                                appCtrl.update();
                                Get.forceAppUpdate();
                              }),
                          contentPadding: EdgeInsets.zero,
                          title: Text(e.value["title"].toString().tr,
                              style: AppCss.outfitMedium16
                                  .textColor(appCtrl.appTheme.txt)),
                          leading: SvgPicture.asset(e.value["icon"].toString())
                              .paddingSymmetric(
                                  vertical: Insets.i12, horizontal: Insets.i15)
                              .decorated(
                                  color:
                                      const Color.fromRGBO(53, 193, 255, 0.1),
                                  shape: BoxShape.circle)
                              .height(Sizes.s40)
                              .width(Sizes.s40),
                        ),
                        if (e.key != appArray.currencyList.length - 1)
                          const Divider(
                            color: Color.fromRGBO(50, 52, 68, 0.08),
                            height: 0,
                          ).marginSymmetric(vertical: Insets.i12),
                      ],
                    ).marginSymmetric(horizontal: Insets.i15))
                .toList(),
            const VSpace(Sizes.s35),
            Row(children: [
              Expanded(
                  child: ButtonCommon(
                      onTap: () {},
                      title: appFonts.cancel,
                      isGradient: false,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.primary),
                      color: appCtrl.appTheme.trans,
                      borderColor: appCtrl.appTheme.primary)),
              const HSpace(Sizes.s15),
              Expanded(child: ButtonCommon(onTap: () {}, title: appFonts.apply))
            ]).marginSymmetric(horizontal: Insets.i15),
            const VSpace(Sizes.s25)
          ],
        )
            .decorated(
                color: appCtrl.appTheme.white,
                borderRadius: BorderRadius.circular(AppRadius.r10))
            .marginSymmetric(horizontal: Insets.i20),
      );
    });
  }
}
