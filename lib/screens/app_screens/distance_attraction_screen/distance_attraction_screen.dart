import '../../../config.dart';

class DistanceAttractionScreen extends StatelessWidget {
  final distanceCtrl = Get.put(DistanceAttractionController());
  DistanceAttractionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistanceAttractionController>(builder: (distanceCtrl) {
      return Scaffold(
        backgroundColor: appCtrl.appTheme.bg1,
        appBar: AppAppBarCommon(
            title: appFonts.distanceAttraction, leadingOnTap: () => Get.back()),
        body: Column(
          children: [
            Column(
              children: [
                textCommon.outfitSemiBoldPrimary16(
                    text: appFonts.visitWonderfulLocationsAroundWorld),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MusicCategoryLayout(
                      title: appFonts.iAmLooking,
                      category: /*socialMediaCtrl.categoryOnSelect ?? */
                          "Restaurant", /* onTap: () => socialMediaCtrl.onSelectMusicCategorySheet() */
                    ),
                    const VSpace(Sizes.s20),
                    MusicCategoryLayout(
                      title: appFonts.theLocationYou,
                      category: /* socialMediaCtrl.categoryOnSelect ?? */
                          "Surat", /*onTap: () => socialMediaCtrl.onSelectMusicCategorySheet() */
                    ),
                    const VSpace(Sizes.s20),
                    textCommon.outfitSemiBoldTxt14(
                        text: appFonts.budgetOfTravelling),
                    const VSpace(Sizes.s60),
                    SfRangeSliderTheme(
                        data: SfRangeSliderThemeData(
                            activeTrackHeight: 3,
                            inactiveTrackHeight: 3,
                            inactiveLabelStyle: AppCss.outfitSemiBold12
                                .textColor(appCtrl.appTheme.lightText),
                            activeLabelStyle: AppCss.outfitSemiBold12
                                .textColor(appCtrl.appTheme.primary),
                            tooltipBackgroundColor: appCtrl.appTheme.primary,
                            inactiveTickColor: appCtrl.appTheme.textField,
                            inactiveTrackColor: appCtrl.appTheme.textField,
                            thumbColor: appCtrl.appTheme.trans),
                        child: SfRangeSlider(
                            min: 5,
                            max: 40,
                            stepSize: 5,
                            startThumbIcon:
                                SvgPicture.asset(eSvgAssets.distanceThumb),
                            endThumbIcon:
                                SvgPicture.asset(eSvgAssets.distanceThumb),
                            values: distanceCtrl.values,
                            interval: 5,
                            shouldAlwaysShowTooltip: true,
                            showLabels: true,
                            onChanged: (SfRangeValues value) {
                              distanceCtrl.values = value;
                              distanceCtrl.update();
                            })),
                  ],
                )
                    .paddingSymmetric(
                        vertical: Insets.i20, horizontal: Insets.i15)
                    .authBoxExtension()
              ],
            )
          ],
        ).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20),
      );
    });
  }
}
