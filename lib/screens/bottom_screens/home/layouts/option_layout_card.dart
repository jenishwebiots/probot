import 'package:probot/config.dart';

class OptionCard extends StatelessWidget {
  final HomeOptionModel? homeOptionModel;

  const OptionCard({Key? key, this.homeOptionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Row(
          children: [
            SvgPicture.asset(homeOptionModel!.image.toString(),
                    height: Sizes.s28,
                    colorFilter: ColorFilter.mode(
                        appCtrl.appTheme.white, BlendMode.srcIn))
                .paddingAll(Insets.i13)
                .decorated(
                    color: appCtrl.appTheme.primary,
                    borderRadius: BorderRadius.circular(AppRadius.r8)),
            const HSpace(Sizes.s11),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(homeOptionModel!.title.toString().tr,
                    style:
                        AppCss.outfitMedium18.textColor(appCtrl.appTheme.txt)),
                const VSpace(Sizes.s5),
                Text(homeOptionModel!.desc.toString().tr,
                    style: AppCss.outfitRegular14
                        .textColor(appCtrl.appTheme.lightText)),
              ],
            )
          ],
        )
            .paddingSymmetric(vertical: Insets.i15, horizontal: Insets.i15)
            .decorated(
                color: appCtrl.appTheme.white,
                borderRadius: BorderRadius.circular(AppRadius.r10),
                boxShadow: [
                  const BoxShadow(
                      color: Color.fromRGBO(53, 193, 255, 0.06),
                      offset: Offset(0, 2),
                      blurRadius: 20)
                ],
                border: Border.all(
                    color: appCtrl.appTheme.radialGradient.withOpacity(.08),
                    width: 1.5))
            .marginOnly(right: Insets.i12),
        SvgPicture.asset(eSvgAssets.rightArrow1, height: Sizes.s10)
            .paddingAll(Insets.i12)
            .decorated(
                color: appCtrl.appTheme.white,
                shape: BoxShape.circle,
                border:
                    Border.all(color: appCtrl.appTheme.borderColor, width: 2))
      ],
    ).marginOnly(bottom: Insets.i15);
  }
}
