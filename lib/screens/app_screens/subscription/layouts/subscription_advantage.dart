import '../../../../config.dart';

class SubscriptionAdvantage extends StatelessWidget {
  const SubscriptionAdvantage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (subscribeCtrl) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("planAdvantage")
              .snapshots(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(flex: 3.5),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          color: appCtrl.appTheme.primaryLight2,
                          border: Border(
                              top: BorderSide(
                                  color: appCtrl.appTheme.primaryLightBorder),
                              bottom: BorderSide(
                                  color: appCtrl.appTheme.primaryLightBorder))),
                      children: [
                        Text(appFonts.advantages.tr,
                                style: AppCss.outfitMedium16
                                    .textColor(appCtrl.appTheme.primary))
                            .paddingSymmetric(
                                horizontal: Insets.i20, vertical: Insets.i14),
                        Text(appFonts.free.tr,
                                textAlign: TextAlign.center,
                                style: AppCss.outfitMedium14
                                    .textColor(appCtrl.appTheme.primary))
                            .paddingSymmetric(
                                horizontal: Insets.i18, vertical: Insets.i14)
                            .decorated(
                                border: Border(
                                    left: BorderSide(
                                        color: appCtrl
                                            .appTheme.primaryLightBorder))),
                        Text(appFonts.pro.tr,
                                textAlign: TextAlign.center,
                                style: AppCss.outfitMedium16
                                    .textColor(appCtrl.appTheme.primary))
                            .paddingSymmetric(
                                horizontal: Insets.i18, vertical: Insets.i14)
                            .decorated(
                                border: Border(
                                    left: BorderSide(
                                        color: appCtrl
                                            .appTheme.primaryLightBorder))),
                      ]),
                  ...snapShot.data!.docs.asMap().entries.map((e) {
                    return TableRow(
                        decoration: BoxDecoration(
                            color: appCtrl.appTheme.white,
                            border: Border(
                                bottom: BorderSide(
                                    color:
                                        e.key != snapShot.data!.docs.length - 1
                                            ? appCtrl.appTheme.white
                                            : appCtrl
                                                .appTheme.primaryLightBorder))),
                        children: [
                          Text(e.value.data()["title"],
                                  style: AppCss.outfitRegular14
                                      .textColor(appCtrl.appTheme.txt))
                              .paddingOnly(
                                  left: Insets.i20,
                                  top: e.key == 0 ? Insets.i16 : 0,
                                  bottom: Insets.i20),
                          SvgPicture.asset(e.key == 0
                                  ? eSvgAssets.offerTick
                                  : eSvgAssets.offerCancel)
                              .paddingOnly(
                                  top: e.key == 0 ? Insets.i14 : 0,
                                  bottom: Insets.i20)
                              .decorated(
                                  border: Border(
                                      left: BorderSide(
                                          color: appCtrl
                                              .appTheme.primaryLightBorder))),
                          SvgPicture.asset(subscribeCtrl.selectedPlan == 0
                                  ? e.value.data()["isWeekly"]
                                      ? eSvgAssets.offerTick
                                      : eSvgAssets.offerCancel
                                  : subscribeCtrl.selectedPlan == 1
                                      ? e.value.data()["isMonthly"]
                                          ? eSvgAssets.offerTick
                                          : eSvgAssets.offerCancel
                                      : e.value.data()["isLimited"]
                                          ? eSvgAssets.offerTick
                                          : eSvgAssets.offerCancel)
                              .paddingOnly(
                                  top: e.key == 0 ? Insets.i14 : 0,
                                  bottom: Insets.i20)
                              .decorated(
                                  border: Border(
                                      left: BorderSide(
                                          color: appCtrl
                                              .appTheme.primaryLightBorder))),
                        ]);
                  }).toList()
                ],
              );
            } else {
              return Container();
            }
          });
    });
  }
}
