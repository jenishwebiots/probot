import '../../../../config.dart';

class TranslationLayout extends StatelessWidget {
  final String? from, to;
  final GestureTapCallback? fromOnTap,toOnTap;
  const TranslationLayout({Key? key, this.from, this.to,this.fromOnTap,this.toOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(appFonts.from.tr,
                style: AppCss.outfitMedium12
                    .textColor(appCtrl.appTheme.lightText)),
            const VSpace(Sizes.s10),
            SizedBox(
                width: Sizes.s120,
                child: Text(from!.tr,
                        style: AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.txt))
                    .paddingAll(Insets.i15)
                    .decorated(
                        color: appCtrl.appTheme.textField,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadius.r8)))).inkWell(onTap: fromOnTap)
          ]),
          Expanded(
              child: Container(height: 1, color: appCtrl.appTheme.primary)
                  .paddingOnly(top: Insets.i20)),
          SizedBox(
                  height: Sizes.s34,
                  width: Sizes.s34,
                  child: SvgPicture.asset(eSvgAssets.translates,
                      fit: BoxFit.scaleDown))
              .decorated(
                  color: appCtrl.appTheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: appCtrl.appTheme.white, width: 1))
              .paddingAll(Insets.i1)
              .decorated(
                  color: appCtrl.appTheme.primary, shape: BoxShape.circle)
              .paddingOnly(top: Insets.i20),
          Expanded(
              child: Container(height: 1, color: appCtrl.appTheme.primary)
                  .paddingOnly(top: Insets.i20)),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(appFonts.to.tr,
                style: AppCss.outfitMedium12
                    .textColor(appCtrl.appTheme.lightText)),
            const VSpace(Sizes.s10),
            SizedBox(
                width: Sizes.s120,
                child: Text(to!.tr,
                        style: AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.txt))
                    .paddingAll(Insets.i15)
                    .decorated(
                        color: appCtrl.appTheme.textField,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadius.r8)))).inkWell(onTap: toOnTap)
          ])
        ]));
  }
}
