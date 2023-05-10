import '../../../../config.dart';

class SelectAmountLayout extends StatelessWidget {
  const SelectAmountLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopUpController>(builder: (topUpCtrl) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const VSpace(Sizes.s15),
        Text(appFonts.selectAmount.tr,
            style: AppCss.outfitSemiBold16
                .textColor(appCtrl.appTheme.txt)
                .letterSpace(.4)),
        const VSpace(Sizes.s18),
        ...appArray.topUpBalanceOption.asMap().entries.map((e) {
          return Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                SvgPicture.asset(e.value["icon"].toString())
                    .paddingAll(Insets.i13)
                    .decorated(
                        color: appCtrl.appTheme.primaryLight,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: appCtrl.appTheme.borderColor)),
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
                                    .getCoins(e.value["price"].toString())
                                    .tr,
                                style: AppCss.outfitMedium14
                                    .textColor(appCtrl.appTheme.lightText))
                          ]))
                    : Text(appFonts.addAmountManually.tr,
                        style: AppCss.outfitSemiBold16
                            .textColor(appCtrl.appTheme.primary))
              ]),
              SelectAmountButton(
                  selectIndex: topUpCtrl.selectedPlan, index: e.key)
            ]),
            if (e.key != 3)
              const Divider(
                      color: Color.fromRGBO(50, 52, 68, 0.08),
                      height: 0,
                      thickness: 1)
                  .paddingSymmetric(vertical: Insets.i15)
          ]).inkWell(onTap: () {
            topUpCtrl.selectedPlan = e.key;
            topUpCtrl.selectedPrice = int.parse(e.value["price"].toString());
            topUpCtrl.update();
          });
        }).toList(),
        if (topUpCtrl.selectedPlan == 3) const AddAmountLayout()
      ])
          .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i15)
          .decorated(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppRadius.r10),
                  bottomRight: Radius.circular(AppRadius.r10)));
    });
  }
}
