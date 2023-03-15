import 'package:flutter_switch/flutter_switch.dart';
import 'package:probot/config.dart';

class Setting extends StatelessWidget {
  final settingCtrl = Get.put(SettingController());

  Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (context) {
      return Scaffold(
        key: settingCtrl.scaffoldKey,
        backgroundColor: appCtrl.appTheme.bg1,
        drawer: const CommonDrawer(),
        appBar: AppBar(
          leadingWidth: Sizes.s80,
          leading: const CommonMenuIcon().inkWell(
              onTap: () => settingCtrl.scaffoldKey.currentState!.openDrawer()),
          automaticallyImplyLeading: false,
          backgroundColor: appCtrl.appTheme.primary,
          title: Text(appFonts.setting.tr,
              style: AppCss.outfitExtraBold22
                  .textColor(appCtrl.appTheme.sameWhite)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(eImageAssets.settingBg).marginOnly(
                      top: Insets.i25,
                      left: Insets.i20,
                      right: Insets.i20,
                      bottom: Insets.i20),
                  Column(
                    children: [
                      Text(
                        "S",
                        style: AppCss.outfitExtraBold30
                            .textColor(appCtrl.appTheme.sameWhite),
                      )
                          .paddingSymmetric(
                              horizontal: Insets.i22, vertical: Insets.i18)
                          .decorated(
                              shape: BoxShape.circle,
                              color: appCtrl.appTheme.primary),
                      const VSpace(Sizes.s10),
                      Text("Shanaya John",
                          style: AppCss.outfitblack18
                              .textColor(appCtrl.appTheme.sameWhite)),
                      const VSpace(Sizes.s3),
                      Text("shanayajohn@gmoil.com",
                          style: AppCss.outfitMedium14
                              .textColor(appCtrl.appTheme.lightText))
                    ],
                  )
                ],
              ),
              const VSpace(Sizes.s20),
              ...settingCtrl.settingList
                  .asMap()
                  .entries
                  .map((e) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    e.value["icon"],
                                    height: Sizes.s20,
                                    width: Sizes.s20,
                                    colorFilter: ColorFilter.mode(
                                        appCtrl.appTheme.txt, BlendMode.srcIn),
                                  ).paddingAll(Insets.i10).decorated(
                                      color: appCtrl.appTheme.white,
                                      shape: BoxShape.circle),
                                  const HSpace(Sizes.s12),
                                  Text(
                                    e.value["title"].toString().tr,
                                    style: AppCss.outfitMedium16
                                        .textColor(appCtrl.appTheme.txt),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  if (e.value["title"] == "language")
                                    Text(
                                      appCtrl.languageVal == "en"
                                          ? "english".tr
                                          : appCtrl.languageVal == "fr"
                                              ? "french".tr
                                              : appCtrl.languageVal == "ge"
                                                  ? "germane".tr
                                                  : appCtrl.languageVal == "hi"
                                                      ? "hindi".tr
                                                      : appCtrl.languageVal ==
                                                              "it"
                                                          ? "italian".tr
                                                          : appCtrl.languageVal ==
                                                                  "ja"
                                                              ? "japanise".tr
                                                              : "arabic",
                                      style: AppCss.outfitMedium14.textColor(
                                          appCtrl.appTheme.lightText),
                                    ).marginSymmetric(horizontal: Insets.i15),
                                  (e.key == 1 || e.key == 6)
                                      ? FlutterSwitch(
                                          padding: 4,
                                          height: Sizes.s20,
                                          toggleSize: 12,
                                          inactiveColor: appCtrl.appTheme.txt
                                              .withOpacity(.1),
                                          width: Sizes.s32,
                                          value: e.key == 6
                                              ? appCtrl.isTheme
                                              : false,
                                          onToggle: (val) {})
                                      : SvgPicture.asset(eSvgAssets.arrowRight1)
                                ],
                              )
                            ],
                          ).paddingSymmetric(horizontal: Insets.i15),
                          const DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 1,
                                  dashLength: 3,
                                  dashColor: Color.fromRGBO(50, 52, 68, 0.1))
                              .marginSymmetric(vertical: Insets.i15)
                        ],
                      ).marginSymmetric(horizontal: Insets.i20))
                  .toList()
            ],
          ),
        ),
      );
    });
  }
}
