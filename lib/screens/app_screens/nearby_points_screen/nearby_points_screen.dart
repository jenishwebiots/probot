import 'package:probot/controllers/app_pages_controllers/nearby_points_controller.dart';

import '../../../config.dart';

class NearbyPointsScreen extends StatelessWidget {
  final nearbyPointCtrl = Get.put(NearbyPointsController());

  NearbyPointsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyPointsController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              title: appFonts.nearbyPoints, leadingOnTap: () => Get.back()),
          body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Column(children: [
                  textCommon.outfitSemiBoldPrimary16(
                      text: appFonts.visitWonderfulLocations),
                  const VSpace(Sizes.s15),
                  Column(
                    children: [
                      MusicCategoryLayout(
                        title: appFonts.iAmLooking,
                        category: /*socialMediaCtrl.categoryOnSelect ??*/
                            "Restaurant", /*onTap: () => socialMediaCtrl.onSelectMusicCategorySheet()*/
                      ),
                      const VSpace(Sizes.s20),
                      MusicCategoryLayout(
                        title: appFonts.myCurrentLocation,
                        category: /*socialMediaCtrl.categoryOnSelect ??*/
                            "Surat", /*onTap: () => socialMediaCtrl.onSelectMusicCategorySheet()*/
                      ),
                      const VSpace(Sizes.s20),
                      textCommon.outfitSemiBoldTxt14(
                          text: appFonts.distanceFrom),
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
                              min: 0,
                              max: 40,
                              stepSize: 5,
                              startThumbIcon:
                                  SvgPicture.asset(eSvgAssets.passwordThumb),
                              endThumbIcon:
                                  SvgPicture.asset(eSvgAssets.passwordThumb),
                              values: nearbyPointCtrl.values,
                              interval: 5,
                              shouldAlwaysShowTooltip: true,
                              minorTicksPerInterval: 7,
                              showLabels: true,
                              onChanged: (SfRangeValues value) {
                                nearbyPointCtrl.values = value;
                                nearbyPointCtrl.update();
                              }))
                    ]
                  )
                      .paddingSymmetric(
                          vertical: Insets.i20, horizontal: Insets.i15)
                      .authBoxExtension()
                ]),
                ButtonCommon(title: appFonts.takeMeTo)
              ])
              .paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20));
    });
  }
}
