import 'package:probot/utils/general_utils.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../../config.dart';
import '../../../common/theme/theme_service.dart';


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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
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
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Image.asset(eImageAssets.rewardBanner,width: Sizes.s182),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appFonts.balance.tr,style: AppCss.outfitSemiBold12.textColor(appCtrl.appTheme.sameWhite.withOpacity(0.8))),
                        const VSpace(Sizes.s10),
                        Text("50${appFonts.rewards.tr}",style: AppCss.outfitBold17.textColor(appCtrl.appTheme.sameWhite))
                      ]
                    ).paddingOnly(left: Insets.i12)
                  ]
                ).inkWell(onTap: ()=> homeCtrl.onTapWatch()),
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
                                  .textColor(appCtrl.appTheme.txt))
                        ))
                    .toList()
              ]
            ).paddingSymmetric(vertical: Insets.i30),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1,
                        dashLength: 3,
                        dashColor: appCtrl.appTheme.txt.withOpacity(.2))
                    .marginSymmetric(vertical: Insets.i20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appFonts.darkTheme.tr,
                        style: AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.txt)),
                    FlutterSwitch(
                      value: appCtrl.isTheme,
                      padding: 4,
                      height: Sizes.s20,
                      toggleSize: 12,
                      inactiveColor: appCtrl.appTheme.txt.withOpacity(.1),
                      width: Sizes.s32,
                      onToggle: (val) {
                        appCtrl.isTheme = val;

                        appCtrl.update();
                        ThemeService().switchTheme(appCtrl.isTheme);
                        Get.forceAppUpdate();
                      },
                    ),
                  ],
                )
              ],
            ).marginOnly(
                left: Insets.i30, bottom: Insets.i50, right: Insets.i30)
          ],
        ),
      );
    });
  }
}
