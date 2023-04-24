import '../../../config.dart';
import 'layouts/translation_layout.dart';

class TranslateScreen extends StatelessWidget {
  final translateCtrl = Get.put(TranslateController());

  TranslateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TranslateController>(builder: (_) {
      return DirectionalityRtl(
        child: Scaffold(
            backgroundColor: appCtrl.appTheme.bg1,
            appBar: AppAppBarCommon(
                title: appFonts.translateAnything,
                leadingOnTap: () => Get.back()),
            body: Stack(children: [
              SingleChildScrollView(
                  child: Column(children: [
                Text(appFonts.selectLanguageAnd.tr,
                    style: AppCss.outfitSemiBold16
                        .textColor(appCtrl.appTheme.primary)
                        .textHeight(1.2)),
                const VSpace(Sizes.s15),
                // translate layout
                Column(children: [
                  TranslationLayout(
                      from: translateCtrl.onFromSelect ?? appFonts.english,
                      to: translateCtrl.onToSelect ?? appFonts.hindi,
                      fromOnTap: () => translateCtrl.onFromLanguageSheet(),
                      toOnTap: () => translateCtrl.onToLanguageSheet()),
                  const VSpace(Sizes.s25),
                  InputLayout(
                      title: appFonts.englishTyping,
                      isMax: true,
                      controller: translateCtrl.transController,
                      onTap: () => translateCtrl.transController.clear())
                ])
                    .paddingSymmetric(
                        horizontal: Insets.i15, vertical: Insets.i20)
                    .authBoxExtension(),
                const VSpace(Sizes.s30),
                if (translateCtrl.isTranslated != true)
                  ButtonCommon(
                          title: appFonts.translate,
                          onTap: () => translateCtrl.onTranslate())
                      .paddingOnly(bottom: Insets.i25),
                if (translateCtrl.isTranslated == true)
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    InputLayout(
                        title: appFonts.hindiTranslate,
                        txtColor: appCtrl.appTheme.primary,
                        responseText: translateCtrl.response,
                        isMax: false,
                        color: appCtrl.appTheme.white,
                        hintText: ''),
                    const VSpace(Sizes.s30),
                    ButtonCommon(
                        title: appFonts.endTranslate,
                        onTap: () => translateCtrl.endTranslationDialog())
                  ])
              ]).paddingAll(Insets.i20)),
              if (translateCtrl.isLoader == true) const LoaderLayout()
            ])),
      );
    });
  }
}
