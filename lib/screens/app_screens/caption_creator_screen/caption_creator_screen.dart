import 'package:probot/controllers/app_pages_controllers/social_media_controller.dart';

import '../../../config.dart';
import 'layouts/platform_layout.dart';

class CaptionCreatorScreen extends StatelessWidget {
  const CaptionCreatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return Scaffold(
        backgroundColor: appCtrl.appTheme.bg1,
        appBar: AppAppBarCommon(
            title: appFonts.captionCreator, leadingOnTap: () => Get.back()),
        body: Column(
          children: [
            Text(appFonts.fillUpTheForm,
                style: AppCss.outfitBold16.textColor(appCtrl.appTheme.primary)),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appFonts.selectPlatform,
                      style: AppCss.outfitSemiBold14
                          .textColor(appCtrl.appTheme.txt)),
                  const VSpace(Sizes.s10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: socialMediaCtrl.captionCreatorLists
                          .asMap()
                          .entries
                          .map((e) => PlatformLayout(
                              data: e.value,
                              index: e.key,
                              selectedIndex: socialMediaCtrl.selectedIndex,
                              onTap: () =>
                                  socialMediaCtrl.onCaptionChange(e.key)))
                          .toList()),
                  const VSpace(Sizes.s28),
                  InputLayout(
                      hintText: appFonts.typeHere,
                      title: appFonts.writeDetail,
                      isMax: true,
                      controller: socialMediaCtrl.captionController,
                      onTap: () => socialMediaCtrl.captionController.clear()),
                  const VSpace(Sizes.s20),
                  Text(appFonts.targetedAudience,
                      style: AppCss.outfitSemiBold14
                          .textColor(appCtrl.appTheme.txt)),
                  const VSpace(Sizes.s10),
                  SfRangeSlider(
                    min: 20,
                    max: 60,
                    stepSize: 5,
                    values: socialMediaCtrl.values,
                    interval: 5,
                    showTicks: true,
                    showLabels: true,
                    onChanged: (SfRangeValues value) {
                      socialMediaCtrl.values = value;
                      socialMediaCtrl.update();
                    },
                  ),
                ],
              ),
            )
                .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
                .authBoxExtension()
          ],
        ).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20),
      );
    });
  }
}
