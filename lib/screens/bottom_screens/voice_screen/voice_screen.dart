import 'dart:developer';

import '../../../config.dart';


class VoiceScreen extends StatelessWidget {
  final voiceCtrl = Get.put(VoiceController());

  VoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoiceController>(builder: (_) {
      return Scaffold(
        drawer: const CommonDrawer(),
        key: voiceCtrl.scaffoldKey,
        backgroundColor: appCtrl.appTheme.bg1,
        appBar: AppBar(
            leadingWidth: Sizes.s70,
            leading: const CommonMenuIcon().inkWell(
                onTap: () => voiceCtrl.scaffoldKey.currentState!.openDrawer()),
            automaticallyImplyLeading: false,
            backgroundColor: appCtrl.appTheme.primary,
            actions: [
              SvgPicture.asset(eSvgAssets.more).paddingOnly(
                  right: appCtrl.isRTL || appCtrl.languageVal == "ar"
                      ? 0
                      : Insets.i15,
                  left: appCtrl.isRTL || appCtrl.languageVal == "ar"
                      ? Insets.i15
                      : 0)
            ],
            title: Text(appFonts.voice.tr,
                style: AppCss.outfitExtraBold22
                    .textColor(appCtrl.appTheme.sameWhite))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: DropdownButton(
                  value: voiceCtrl.langValue,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppRadius.r8)),
                  style: AppCss.outfitMedium14
                      .textColor(appCtrl.appTheme.lightText),
                  icon: SvgPicture.asset(eSvgAssets.dropDown),
                  isDense: true,
                  isExpanded: true,
                  hint: Text(appFonts.english.toString().tr),
                  items: voiceCtrl.selectLanguageLists
                      .map((item) =>
                  DropdownMenuItem(value: item.title, child: Text(item.title!))
                  )
                      .toList(),
                  onChanged: (val) async{
                    voiceCtrl.langValue = val.toString();
                    voiceCtrl.update();
                  }).paddingOnly(
                  top: Insets.i50, bottom: Insets.i10),
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
                      children: [],
                    ))),
            Text(appFonts.pressTheButton,
                textAlign: TextAlign.center,
                style: AppCss.outfitMedium14
                    .textColor(appCtrl.appTheme.lightText)
                    .textHeight(1.3))
                .padding(horizontal: Insets.i40, bottom: Insets.i25),
            Image.asset(eImageAssets.voice, height: Sizes.s60)
                .inkWell(onTap: () {})
                .paddingSymmetric(vertical: Insets.i15)
          ],
        ),
      );
    });
  }
}