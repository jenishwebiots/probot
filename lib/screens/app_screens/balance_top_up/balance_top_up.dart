import 'package:probot/controllers/app_pages_controllers/top_up_controller.dart';

import '../../../config.dart';

class BalanceTopUp extends StatelessWidget {
  final topUpCtrl = Get.put(TopUpController());

  BalanceTopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopUpController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              title: appFonts.purchaseCoinBalance,
              actionIcon: eSvgAssets.currency,
              isAction: true,
              isBalanceShow: false,
              leadingOnTap: () => Get.back(),
              actionOnTap: () => topUpCtrl.currencyListDialog()),
          body: SingleChildScrollView(
              child: Column(children: [
            Stack(alignment: Alignment.center, children: [
              Image.asset(
                eImageAssets.topUpBg,
                height: Sizes.s50,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(appFonts.coinBalance.tr,
                    style: AppCss.outfitMedium14
                        .textColor(appCtrl.appTheme.sameWhite)),
                Row(children: [
                  Text("${appCtrl.envConfig["balance"]} ${appFonts.coin.tr}",
                      style: AppCss.outfitSemiBold16
                          .textColor(appCtrl.appTheme.sameWhite)),
                  const HSpace(Sizes.s6),
                  SvgPicture.asset(eSvgAssets.coin, height: Sizes.s30)
                ])
              ]).marginSymmetric(horizontal: Insets.i15)
            ]),
            const VSpace(Sizes.s20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.circle,
                      color: appCtrl.appTheme.primary, size: Sizes.s5),
                  const HSpace(Sizes.s5),
                  Text(appFonts.getCoinAccordance.tr,
                      style: AppCss.outfitRegular14
                          .textColor(appCtrl.appTheme.primary))
                ]),
                const VSpace(Sizes.s12),
                Row(children: [
                  Icon(Icons.circle,
                      color: appCtrl.appTheme.primary, size: Sizes.s5),
                  const HSpace(Sizes.s5),
                  Text(appFonts.exIfYouAdd.tr,
                      style: AppCss.outfitRegular14
                          .textColor(appCtrl.appTheme.primary))
                ])
              ]).paddingAll(Insets.i20).decorated(
                  color: appCtrl.appTheme.primaryLight1,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(AppRadius.r10),
                      topLeft: Radius.circular(AppRadius.r10))),
              Divider(
                  color: appCtrl.appTheme.primaryLight1,
                  height: 0,
                  thickness: 1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VSpace(Sizes.s15),
                  Text(appFonts.selectAmount.tr,
                      style: AppCss.outfitSemiBold16
                          .textColor(appCtrl.appTheme.txt)
                          .letterSpace(.4)),
                  const VSpace(Sizes.s18),
                  ...appArray.topUpBalanceOption.asMap().entries.map((e) {
                    return Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              SvgPicture.asset(e.value["icon"].toString())
                                  .paddingAll(Insets.i13)
                                  .decorated(
                                      color: appCtrl.appTheme.primaryLight,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: appCtrl.appTheme.borderColor)),
                              const HSpace(Sizes.s12),
                              e.key != 3
                                  ? RichText(
                                      text: TextSpan(
                                          text:
                                              "${appCtrl.priceSymbol}${appCtrl.priceSymbol == "₹" ? (appCtrl.currencyVal * double.parse(e.value["price"].toString())) : (appCtrl.currencyVal * double.parse(e.value["price"].toString())).toStringAsFixed(2)} - ",
                                          style: AppCss.outfitSemiBold16
                                              .textColor(appCtrl.appTheme.txt),
                                          children: <TextSpan>[
                                          TextSpan(
                                              text: appFonts
                                                  .getCoins(e.value["price"]
                                                      .toString())
                                                  .tr,
                                              style: AppCss.outfitMedium14
                                                  .textColor(appCtrl
                                                      .appTheme.lightText)),
                                        ]))
                                  : Text(appFonts.addAmountManually.tr,
                                      style: AppCss.outfitSemiBold16
                                          .textColor(appCtrl.appTheme.primary))
                            ]),
                            Container(
                                padding: const EdgeInsets.all(Insets.i3),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: topUpCtrl.selectedPlan == e.key
                                            ? appCtrl.appTheme.primary
                                            : appCtrl.appTheme.lightText)),
                                child: Icon(Icons.circle,
                                    size: 10,
                                    color: topUpCtrl.selectedPlan == e.key
                                        ? appCtrl.appTheme.primary
                                        : appCtrl.appTheme.trans))
                          ]),
                      if (e.key != 3)
                        const Divider(
                          color: Color.fromRGBO(50, 52, 68, 0.08),
                          height: 0,
                          thickness: 1,
                        ).paddingSymmetric(vertical: Insets.i15)
                    ]).inkWell(onTap: () {
                      topUpCtrl.selectedPlan = e.key;
                      topUpCtrl.selectedPrice =
                          int.parse(e.value["price"].toString());
                      topUpCtrl.update();
                    });
                  }).toList(),
                  if (topUpCtrl.selectedPlan == 3)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(appFonts.addAmount.tr,
                              style: AppCss.outfitSemiBold16
                                  .textColor(appCtrl.appTheme.txt)),
                          const VSpace(Sizes.s8),
                          TextFieldCommon(
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  topUpCtrl.selectedPrice = 0;
                                }
                                topUpCtrl.update();
                                return null;
                              },
                              onChanged: (val) {
                                if (val.isNotEmpty) {
                                  topUpCtrl.selectedPrice =
                                      int.parse(val.toString());
                                } else {
                                  topUpCtrl.selectedPrice = 0;
                                }
                                topUpCtrl.update();
                              },
                              controller: topUpCtrl.txtAmount,
                              hintText: "\$30")
                        ]).paddingSymmetric(vertical: Insets.i15)
                ]
              )
                  .paddingSymmetric(
                      horizontal: Insets.i20, vertical: Insets.i15)
                  .decorated(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(AppRadius.r10),
                          bottomRight: Radius.circular(AppRadius.r10)))
            ]).decorated(
                color: appCtrl.appTheme.white,
                borderRadius: BorderRadius.circular(AppRadius.r10),
                border: Border.all(color: appCtrl.appTheme.primaryLight1),
                boxShadow: [
                  BoxShadow(
                      color: appCtrl.isTheme
                          ? appCtrl.appTheme.trans
                          : appCtrl.appTheme.primary.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4)
                ]),
            const VSpace(Sizes.s28),
            ButtonCommon(
                onTap: () {
                  topUpCtrl.paymentDialog(topUpCtrl.selectedPrice.toString());
                },
                title: topUpCtrl.selectedPrice == 0
                    ? appFonts.pay.tr
                    : "${appFonts.pay.tr} ${topUpCtrl.selectedPrice}")
          ]).marginAll(Insets.i20)));
    });
  }
}
