import '../../../config.dart';

class CodeGeneratorScreen extends StatelessWidget {
  final codeGeneratorCtrl = Get.put(CodeGeneratorController());

  CodeGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CodeGeneratorController>(builder: (_) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              title: appFonts.codeGenerator, leadingOnTap: () => Get.back()),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: codeGeneratorCtrl.isCodeGenerate == true
                    ? Column(
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
                                responseText: codeGeneratorCtrl.response)
                          ]),
                      const VSpace(Sizes.s30),
                      ButtonCommon(
                          title: appFonts.endCodeGenerator,
                          onTap: () =>
                              codeGeneratorCtrl.endCodeGeneratorDialog())
                    ]).paddingSymmetric(
                    horizontal: Insets.i20, vertical: Insets.i30)
                    : SingleChildScrollView(
                    child: Column(
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
                                child: Text(codeGeneratorCtrl.onSelect ?? "C#",
                                    style: AppCss.outfitMedium16
                                        .textColor(appCtrl.appTheme.txt))
                                    .paddingAll(Insets.i15)
                                    .decorated(
                                    color: appCtrl.appTheme.textField,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(AppRadius.r8))))
                                .inkWell(
                                onTap: () =>
                                    codeGeneratorCtrl.onSelectLanguageSheet()),
                            const VSpace(Sizes.s28),
                            InputLayout(
                                title: appFonts.writeStuff,
                                isMax: true,
                                controller: codeGeneratorCtrl.codeController,
                                onTap: () =>
                                    codeGeneratorCtrl.codeController.clear())
                          ])
                          .paddingSymmetric(
                          horizontal: Insets.i15, vertical: Insets.i20)
                          .authBoxExtension(),
                      const VSpace(Sizes.s40),
                      ButtonCommon(
                          title: appFonts.createMagicalCode,
                          onTap: () => codeGeneratorCtrl.onCodeGenerate())
                    ]).paddingSymmetric(
                        horizontal: Insets.i20, vertical: Insets.i30))
              ),
              if(codeGeneratorCtrl.isLoader == true) const LoaderLayout()
            ]
          ));
    });
  }
}
