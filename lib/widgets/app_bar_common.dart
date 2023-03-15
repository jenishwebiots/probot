import '../config.dart';

class AppAppBarCommon extends StatelessWidget with PreferredSizeWidget {
  final GestureTapCallback? onTap;
  final String? title,actionIcon;
  const AppAppBarCommon({Key? key,this.title,this.onTap,this.actionIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: appCtrl.appTheme.primary,
      actions: [
        SvgPicture.asset(actionIcon!).paddingSymmetric(horizontal: Insets.i20).inkWell(onTap: onTap)
      ],
      title: Row(
        children: [
          const HSpace(Sizes.s10),
          SvgPicture.asset(eSvgAssets.leftArrow,
              fit: BoxFit.scaleDown,
              colorFilter:
              ColorFilter.mode(appCtrl.isTheme ? appCtrl.appTheme.sameWhite : appCtrl.appTheme.white, BlendMode.srcIn)),
          const HSpace(Sizes.s17),
          Text(title!, style: AppCss.outfitSemiBold22.textColor(appCtrl.appTheme.sameWhite))
        ]
      )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
