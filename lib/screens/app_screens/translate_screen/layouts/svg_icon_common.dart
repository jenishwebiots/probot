import '../../../../config.dart';

class SvgIconsCommon extends StatelessWidget {
  final String? icon;
  final GestureTapCallback? onTap;
  const SvgIconsCommon({Key? key,this.icon,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: SvgPicture.asset(icon!,height: Sizes.s20,
            colorFilter: ColorFilter.mode(
                appCtrl.appTheme.primary, BlendMode.srcIn))).inkWell(onTap: onTap)
        .paddingAll(Insets.i7)
        .decorated(
        color: appCtrl.appTheme.primaryLight,
        borderRadius: const BorderRadius.all(
            Radius.circular(AppRadius.r4)));
  }
}
