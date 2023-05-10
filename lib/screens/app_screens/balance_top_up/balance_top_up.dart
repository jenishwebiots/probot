import '../../../config.dart';
import 'layouts/select_amount_layout.dart';
import 'layouts/top_up_note_layout.dart';

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
              Image.asset(eImageAssets.topUpBg,
                  height: Sizes.s50,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill),
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
                TopUpNoteLayout(title: appFonts.getCoinAccordance),
                const VSpace(Sizes.s12),
                TopUpNoteLayout(title: appFonts.exIfYouAdd)
              ]).paddingAll(Insets.i20).decorated(
                  color: appCtrl.appTheme.primaryLight1,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(AppRadius.r10),
                      topLeft: Radius.circular(AppRadius.r10))),
              Divider(
                  color: appCtrl.appTheme.primaryLight1,
                  height: 0,
                  thickness: 1),
              const SelectAmountLayout()
            ]).selectAmountExtension(),
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
