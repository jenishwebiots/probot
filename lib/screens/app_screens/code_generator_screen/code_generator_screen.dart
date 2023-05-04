import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vibration/vibration.dart';
import '../../../config.dart';

class CodeGeneratorScreen extends StatelessWidget {
  final codeGeneratorCtrl = Get.put(CodeGeneratorController());

  CodeGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CodeGeneratorController>(builder: (_) {
      return WillPopScope(
        onWillPop: () => textToSpeechCtrl.onStopTTS(),
        child: DirectionalityRtl(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: appCtrl.appTheme.bg1,
              appBar: AppAppBarCommon(
                  title: appFonts.codeGenerator, leadingOnTap: () {
                textToSpeechCtrl.onStopTTS();
                Get.back();
              }),
              body: Stack(alignment: Alignment.bottomCenter, children: [
                codeGeneratorCtrl.isCodeGenerate == true
                    ? SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(appFonts.weCreatedIncredible.tr,
                                  style: AppCss.outfitSemiBold16
                                      .textColor(appCtrl.appTheme.primary)),
                              const VSpace(Sizes.s23),
                              InputLayout(
                                  color: appCtrl.appTheme.white,
                                  title: appFonts.generatedCode,
                                  isMax: false,
                                  text: codeGeneratorCtrl.response,
                                  responseText: codeGeneratorCtrl.response)
                            ]),
                        const VSpace(Sizes.s30),
                        ButtonCommon(
                            title: appFonts.endCodeGenerator,
                            onTap: () =>
                                codeGeneratorCtrl.endCodeGeneratorDialog()),
                      ]).paddingSymmetric(
                      horizontal: Insets.i20, vertical: Insets.i30),
                )
                    : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appFonts.typeAnythingTo.tr,
                          style: AppCss.outfitSemiBold16
                              .textColor(appCtrl.appTheme.primary)),
                      const VSpace(Sizes.s15),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appFonts.selectLanguage.tr,
                                style: AppCss.outfitSemiBold14
                                    .textColor(appCtrl.appTheme.txt)),
                            const VSpace(Sizes.s8),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                    codeGeneratorCtrl.onSelect ??
                                        "C#",
                                    style: AppCss.outfitMedium16
                                        .textColor(
                                        appCtrl.appTheme.txt))
                                    .paddingAll(Insets.i15)
                                    .decorated(
                                    color:
                                    appCtrl.appTheme.textField,
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(
                                            AppRadius.r8))))
                                .inkWell(
                                onTap: () =>
                                    codeGeneratorCtrl
                                        .onSelectLanguageSheet()),
                            const VSpace(Sizes.s28),
                            InputLayout(
                                title: appFonts.writeStuff,
                                isMax: true,
                                microPhoneTap: () {
                                  Vibration.vibrate(duration: 200);
                                  codeGeneratorCtrl.speechToText();
                                },
                                isAnimated:
                                codeGeneratorCtrl.isListening.value,
                                height: codeGeneratorCtrl.isListening.value
                                    ? codeGeneratorCtrl.animation!.value
                                    : Sizes.s20,
                                controller:
                                codeGeneratorCtrl.codeController,
                                onTap: () =>
                                    codeGeneratorCtrl
                                        .codeController
                                        .clear())
                          ])
                          .paddingSymmetric(
                          horizontal: Insets.i15, vertical: Insets.i20)
                          .authBoxExtension(),
                      const VSpace(Sizes.s40),
                      ButtonCommon(
                          title: appFonts.createMagicalCode,
                          onTap: () => codeGeneratorCtrl.onCodeGenerate()),
                    ]).paddingSymmetric(
                    horizontal: Insets.i20, vertical: Insets.i30),
                /*if (!appCtrl.isSubscribe)
                  if (appCtrl.firebaseConfigModel!.isAddShow!)
                    appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!
                        ? (codeGeneratorCtrl.bannerAd != null &&
                                codeGeneratorCtrl.bannerAdIsLoaded)
                            ? AdWidget(ad: codeGeneratorCtrl.bannerAd!)
                                .height(Sizes.s50)
                                .paddingOnly(bottom: Insets.i10)
                                .width(MediaQuery.of(context).size.width)
                            : Container()
                        : Container(
                                alignment: Alignment.bottomCenter,
                                child: codeGeneratorCtrl.currentAd)
                            .paddingSymmetric(
                                vertical: Insets.i15, horizontal: Insets.i20)
                            .width(MediaQuery.of(context).size.width),*/
                if (codeGeneratorCtrl.isCodeGenerate == false)
                  AdCommonLayout(
                      bannerAd: codeGeneratorCtrl.bannerAd,
                      bannerAdIsLoaded: codeGeneratorCtrl.bannerAdIsLoaded,
                      currentAd: codeGeneratorCtrl.currentAd),
                if (codeGeneratorCtrl.isLoader == true) const LoaderLayout()
              ])),
        ),
      );
    });
  }
}
