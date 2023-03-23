import 'package:probot/utils/general_utils.dart';
import '../../../../../config.dart';
import 'layouts/bottom_layout.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeCtrl) {
      return Drawer(
          width: Sizes.s223,
          backgroundColor: appCtrl.appTheme.boxBg,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Insets.i20),
                  bottomRight: Radius.circular(Insets.i20))),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Column(children: [
              Image.asset(eImageAssets.proBot).marginOnly(
                  left: Insets.i45,
                  top: Insets.i20,
                  bottom: Insets.i30,
                  right: Insets.i45),
              DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1,
                      dashLength: 3,
                      dashColor: appCtrl.appTheme.txt.withOpacity(.2))
                  .marginSymmetric(horizontal: Insets.i20),
              const VSpace(Sizes.s15),
              Stack(alignment: Alignment.centerLeft, children: [
                Image.asset(eImageAssets.rewardBanner, width: Sizes.s182),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(appFonts.balance.tr,
                      style: AppCss.outfitSemiBold12.textColor(
                          appCtrl.appTheme.sameWhite.withOpacity(0.8))),
                  const VSpace(Sizes.s10),
                  Text("50${appFonts.rewards.tr}",
                      style: AppCss.outfitBold17
                          .textColor(appCtrl.appTheme.sameWhite))
                ]).paddingOnly(left: Insets.i12)
              ]).inkWell(onTap: () => homeCtrl.onTapWatch()),
              ...homeCtrl.drawerList
                  .asMap()
                  .entries
                  .map((e) => ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: Insets.i20, vertical: Insets.i5),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                      onTap: () => appCtrl.onDrawerTap(e.key),
                      leading: SvgPicture.asset(e.value["icon"],
                          colorFilter: ColorFilter.mode(
                              appCtrl.appTheme.txt, BlendMode.srcIn)),
                      title: Text(trans(e.value["title"]),
                          style: AppCss.outfitRegular16
                              .textColor(appCtrl.appTheme.txt))))
                  .toList()
            ]).paddingSymmetric(vertical: Insets.i30),
            const BottomLayout()
          ]));
    });
  }
}
