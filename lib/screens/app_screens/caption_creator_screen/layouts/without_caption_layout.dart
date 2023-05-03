import 'package:vibration/vibration.dart';

import '../../../../config.dart';

class WithoutCaptionLayout extends StatelessWidget {
  const WithoutCaptionLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text(appFonts.fillUpTheForm.tr,
        style: AppCss.outfitBold16.textColor(appCtrl.appTheme.primary)),
        const VSpace(Sizes.s15),
        SizedBox(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Text(appFonts.selectPlatform.tr,
              style:
                  AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
          const VSpace(Sizes.s10),
          Wrap(
              children: socialMediaCtrl.captionCreatorLists
                  .asMap()
                  .entries
                  .map((e) => /*Column(
                    children: [
                      Text("data").height(20).width(100).backgroundColor(appCtrl.appTheme.error).paddingOnly(right: Insets.i10,bottom: Insets.i10),
                    ],
                  )*/ PlatformLayout(
                      data: e.value,
                      index: e.key,
                      selectedIndex: socialMediaCtrl.selectedIndex,
                      onTap: () => socialMediaCtrl.onPlatformChange(e.key)).paddingOnly(bottom: Insets.i10,right: Insets.i10))
                  .toList()),
          const VSpace(Sizes.s28),
          InputLayout(
              hintText: appFonts.typeHere,
              title: appFonts.writeDetail,
              isMax: true,
              isAnimated: socialMediaCtrl.isListening.value,
              height: socialMediaCtrl.isListening.value
                  ? socialMediaCtrl.animation!.value
                  : Sizes.s20,
              microPhoneTap: (){
                Vibration.vibrate(duration: 200);
                socialMediaCtrl.speechToText();
              },
              controller: socialMediaCtrl.captionController,
              onTap: () => socialMediaCtrl.captionController.clear()),
          const VSpace(Sizes.s20),
          Text(appFonts.targetedAudience.tr,
              style:
                  AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
          const VSpace(Sizes.s10),
          const TargetAudienceSliderLayout(),
          const VSpace(Sizes.s20),
          Text(appFonts.captionTone.tr,
              style:
                  AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
          const VSpace(Sizes.s10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: socialMediaCtrl.captionToneLists
                  .asMap()
                  .entries
                  .map((e) => CaptionToneLayout(
                      data: e.value,
                      index: e.key,
                      selectedIndex: socialMediaCtrl.selectedIndexTone,
                      onTap: () =>
                          socialMediaCtrl.onCaptionToneChange(e.key)))
                  .toList())
        ]))
        .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
        .authBoxExtension(),
        const VSpace(Sizes.s30),
        ButtonCommon(title: appFonts.bringMeTheBest,onTap: ()=> socialMediaCtrl.onCaptionGenerate())
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
