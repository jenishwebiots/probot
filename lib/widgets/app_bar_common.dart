import '../config.dart';

class AppBarCommon extends StatelessWidget with PreferredSizeWidget {
  const AppBarCommon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: appCtrl.appTheme.bg1,
        elevation: 0,
        leading: SvgPicture.asset(eSvgAssets.leftArrow, fit: BoxFit.scaleDown)
            .inkWell(onTap: () => Get.back()),
        title: Image.asset(eImageAssets.proBot,
            height: Sizes.s38, width: Sizes.s130));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
