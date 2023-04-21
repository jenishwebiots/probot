import '../../../config.dart';

class MusicForPostScreen extends StatelessWidget {
  const MusicForPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              title: appFonts.musicForPost, leadingOnTap: () => Get.back()),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: socialMediaCtrl.isMusicGenerated == true
                    ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appFonts.highestQuality,
                                style: AppCss.outfitBold16
                                    .textColor(appCtrl.appTheme.primary)),
                            const VSpace(Sizes.s15),
                            InputLayout(
                                hintText: appFonts.typeHere,
                                title: appFonts.musicSuggestion,
                                isMax: false,
                                color: appCtrl.appTheme.white,
                                responseText: socialMediaCtrl.musicResponse)
                          ]),
                      const VSpace(Sizes.s30),
                      ButtonCommon(
                          title: appFonts.endMusicGeneration,
                          onTap: () =>
                              socialMediaCtrl.endMusicGeneratorDialog())
                    ]).paddingSymmetric(
                    vertical: Insets.i30, horizontal: Insets.i20)
                    : Column(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appFonts.acquireTheRight,
                            style: AppCss.outfitBold16
                                .textColor(appCtrl.appTheme.primary)),
                        const VSpace(Sizes.s15),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MusicCategoryLayout(
                                  title: appFonts.selectMusicCategory,
                                  category: socialMediaCtrl.categoryOnSelect ??
                                      "Classic",
                                  onTap: () => socialMediaCtrl
                                      .onSelectMusicCategorySheet()),
                              const VSpace(Sizes.s20),
                              MusicCategoryLayout(
                                  title: appFonts.selectLanguage,
                                  category: socialMediaCtrl.onSelect ?? "Hindi",
                                  onTap: () =>
                                      socialMediaCtrl.onSelectLanguageSheet())
                            ])
                            .paddingSymmetric(
                            vertical: Insets.i20, horizontal: Insets.i15)
                            .authBoxExtension()
                      ]),
                  const VSpace(Sizes.s30),
                  ButtonCommon(
                      title: appFonts.generateSuitableMusic,
                      onTap: () => socialMediaCtrl.onMusicGenerate())
                ]).paddingSymmetric(
                    vertical: Insets.i30, horizontal: Insets.i20),
              ),
              if(socialMediaCtrl.isLoader == true) const LoaderLayout()
            ]
          ));
    });
  }
}
