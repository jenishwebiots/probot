import '../../../config.dart';

class DistanceAttractionScreen extends StatelessWidget {
  final distanceCtrl = Get.put(DistanceAttractionController());

  DistanceAttractionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistanceAttractionController>(builder: (distanceCtrl) {
      return WillPopScope(
        onWillPop: () => textToSpeechCtrl.onStopTTS(),
        child: DirectionalityRtl(
          child: Scaffold(
              backgroundColor: appCtrl.appTheme.bg1,
              appBar: AppAppBarCommon(
                  title: appFonts.distanceAttraction,
                  leadingOnTap: () {
                    textToSpeechCtrl.onStopTTS();
                    Get.back();
                  }),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          distanceCtrl.isDistanceGenerated == false
                              ? Column(children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textCommon.outfitSemiBoldPrimary16(
                                            text: appFonts
                                                .visitWonderfulLocationsAroundWorld),
                                        const VSpace(Sizes.s15),
                                        Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              MusicCategoryLayout(
                                                  title: appFonts.iAmLooking,
                                                  category: distanceCtrl
                                                          .placeOnSelect ??
                                                      "Restaurant",
                                                  onTap: () => distanceCtrl
                                                      .onPlaceSheet()),
                                              const VSpace(Sizes.s20),
                                              MusicCategoryLayout(
                                                  title:
                                                      appFonts.theLocationYou,
                                                  category:
                                                      distanceCtrl.onSelect ??
                                                          "Surat",
                                                  onTap: () => distanceCtrl
                                                      .onCitySheet()),
                                              const VSpace(Sizes.s20),
                                              textCommon.outfitSemiBoldTxt14(
                                                  text: appFonts
                                                      .budgetOfTravelling),
                                              const VSpace(Sizes.s60),
                                              const DistanceSliderLayout()
                                            ])
                                            .paddingSymmetric(
                                                vertical: Insets.i20,
                                                horizontal: Insets.i15)
                                            .authBoxExtension()
                                      ]),
                                  const VSpace(Sizes.s30),
                                  ButtonCommon(
                                      title: appFonts.takeMeTo,
                                      onTap: () =>
                                          distanceCtrl.onDistanceGenerate())
                                ])
                              : const DistanceGeneratedLayout()
                        ]).paddingSymmetric(
                        vertical: Insets.i30, horizontal: Insets.i20),
                  ),
                  if (distanceCtrl.isDistanceGenerated == false)
                    AdCommonLayout(
                        bannerAd: distanceCtrl.bannerAd,
                        bannerAdIsLoaded: distanceCtrl.bannerAdIsLoaded,
                        currentAd: distanceCtrl.currentAd),
                  if (distanceCtrl.isLoader == true) const LoaderLayout()
                ],
              )),
        ),
      );
    });
  }
}
