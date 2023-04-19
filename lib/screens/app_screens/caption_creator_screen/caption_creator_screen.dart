import '../../../config.dart';


class CaptionCreatorScreen extends StatelessWidget {
  const CaptionCreatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              title: appFonts.captionCreator, leadingOnTap: () => Get.back()),
          body: socialMediaCtrl.isCaptionGenerated == true ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(appFonts.fantasticSuggestion,
                      style: AppCss.outfitBold16
                          .textColor(appCtrl.appTheme.primary)),
                  const VSpace(Sizes.s15),
                  InputLayout(
                      hintText: appFonts.typeHere,
                      title: appFonts.amazingCaption,
                      color: appCtrl.appTheme.white,
                      isMax: false,
                      controller: socialMediaCtrl.captionGeneratedController)
                ]),
                ButtonCommon(title: appFonts.endCaptionCreator,onTap: ()=> socialMediaCtrl.endCaptionGeneratorDialog(),)
              ]).paddingSymmetric(
              vertical: Insets.i30,
              horizontal: Insets.i20) : const WithoutCaptionLayout()
          );
    });
  }
}
