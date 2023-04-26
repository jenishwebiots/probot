import '../config.dart';

class CommonSubscribeTitle extends StatelessWidget {
  final SubscribeModel? subscribeModel;
  final bool? isActivePlan;

  const CommonSubscribeTitle({Key? key, this.subscribeModel, this.isActivePlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          eSvgAssets.crown,
          colorFilter: ColorFilter.mode(
              isActivePlan!
                  ? appCtrl.appTheme.sameWhite
                  : appCtrl.appTheme.primary,
              BlendMode.srcIn),
        ),
        const HSpace(Sizes.s8),
        RichText(
            text: TextSpan(
                text: "${subscribeModel!.type!.tr.toUpperCase()} ",
                style: AppCss.outfitSemiBold14.textColor(isActivePlan!
                    ? appCtrl.appTheme.sameWhite
                    : appCtrl.appTheme.primary),
                children: <TextSpan>[
              TextSpan(
                  text: "PLAN",
                  style: AppCss.outfitMedium14.textColor(isActivePlan!
                      ? appCtrl.appTheme.sameWhite
                      : appCtrl.appTheme.primary)),
            ]))
      ],
    ).paddingSymmetric(vertical: Insets.i15).decorated(
        color: isActivePlan!
            ? appCtrl.appTheme.yellowColor
            : appCtrl.appTheme.primaryLight1,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(AppRadius.r10),
            topLeft: Radius.circular(AppRadius.r10)));
  }
}
