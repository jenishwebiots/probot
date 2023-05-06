import '../../../config.dart';

class MusicForPostScreen extends StatelessWidget {
  const MusicForPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppAppBarCommon(
                      title: appFonts.musicForPost,
                      leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                  body: Stack(children: [
                    SingleChildScrollView(
                        child: socialMediaCtrl.isMusicGenerated == true
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(appFonts.highestQuality.tr,
                                              style: AppCss.outfitBold16
                                                  .textColor(appCtrl
                                                      .appTheme.primary)),
                                          const VSpace(Sizes.s15),
                                          InputLayout(
                                              hintText: appFonts.typeHere,
                                              title: appFonts.musicSuggestion,
                                              isMax: false,
                                              color: appCtrl.appTheme.white,
                                              text:
                                                  socialMediaCtrl.musicResponse,
                                              responseText:
                                                  socialMediaCtrl.musicResponse)
                                        ]),
                                    ButtonCommon(
                                        title: appFonts.endMusicGeneration,
                                        onTap: () => socialMediaCtrl
                                            .endMusicGeneratorDialog()),
                                    const VSpace(Sizes.s30),
                                  ]).paddingSymmetric(
                                vertical: Insets.i30, horizontal: Insets.i20)
                            : Column(children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(appFonts.acquireTheRight.tr,
                                          style: AppCss.outfitBold16.textColor(
                                              appCtrl.appTheme.primary)),
                                      const VSpace(Sizes.s15),
                                      Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            MusicCategoryLayout(
                                                title: appFonts
                                                    .selectMusicCategory,
                                                category: socialMediaCtrl
                                                        .categoryOnSelect ??
                                                    "Classic",
                                                onTap: () => socialMediaCtrl
                                                    .onSelectMusicCategorySheet()),
                                            const VSpace(Sizes.s20),
                                            MusicCategoryLayout(
                                                title: appFonts.selectLanguage,
                                                category:
                                                    socialMediaCtrl.onSelect ??
                                                        "Hindi",
                                                onTap: () => socialMediaCtrl
                                                    .onSelectLanguageSheet())
                                          ])
                                          .paddingSymmetric(
                                              vertical: Insets.i20,
                                              horizontal: Insets.i15)
                                          .authBoxExtension()
                                    ]),
                                const VSpace(Sizes.s30),
                                ButtonCommon(
                                    title: appFonts.generateSuitableMusic,
                                    onTap: () =>
                                        socialMediaCtrl.onMusicGenerate()),
                              ]).paddingSymmetric(
                                vertical: Insets.i30, horizontal: Insets.i20)),
                    if (socialMediaCtrl.isLoader == true) const LoaderLayout()
                  ]))));
    });
  }
}
