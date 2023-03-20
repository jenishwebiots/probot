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
            leadingWidth: Sizes.s70,
            leading: const CommonMenuIcon().inkWell(
                onTap: () =>
                    settingCtrl.scaffoldKey.currentState!.openDrawer()),
            automaticallyImplyLeading: false,
            backgroundColor: appCtrl.appTheme.primary,
            title: Text(appFonts.setting.tr,
                style: AppCss.outfitExtraBold22
                    .textColor(appCtrl.appTheme.sameWhite))),
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(alignment: Alignment.center, children: [
            Image.asset(eImageAssets.settingBg).marginOnly(
                top: Insets.i25,
                left: Insets.i20,
                right: Insets.i20,
                bottom: Insets.i20),
            Column(children: [
              Text(
                      settingCtrl.userName != null
                          ? settingCtrl.userName![0]
                          : settingCtrl.name != null
                              ? settingCtrl.name![0]
                              : "S",
                      style: AppCss.outfitExtraBold30
                          .textColor(appCtrl.appTheme.sameWhite))
                  .paddingSymmetric(
                      horizontal: Insets.i22, vertical: Insets.i18)
                  .decorated(
                      shape: BoxShape.circle, color: appCtrl.appTheme.primary),
              const VSpace(Sizes.s10),
              Column(children: [
                Text("Shanaya John",
                    style: AppCss.outfitblack18
                        .textColor(appCtrl.appTheme.sameWhite)),
                const VSpace(Sizes.s3)
              ]),
              Text("shanayajohn@gmoil.com",
                  style: AppCss.outfitMedium14
                      .textColor(appCtrl.appTheme.lightText))
            ])
          ]),
          const VSpace(Sizes.s20),
          ...settingCtrl.settingList
              .asMap()
              .entries
              .map((e) => SettingList(index: e.key, data: e.value)
                  .marginSymmetric(horizontal: Insets.i20))
              .toList()
        ]).marginOnly(bottom: Insets.i25)),
      );
    });
  }
}
