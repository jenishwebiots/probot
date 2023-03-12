import '../../../config.dart';

class SelectLanguageScreen extends StatelessWidget {
  final languageCtrl = Get.put(SelectLanguageController());
  SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectLanguageController>(builder: (_) {
      return Scaffold(
        backgroundColor: appCtrl.appTheme.bg1,
        appBar: const AppBarCommon(),
        body: Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(appFonts.selectLanguage,
                                    style: AppCss.outfitSemiBold22
                                        .textColor(appCtrl.appTheme.txt)),
                                const VSpace(Sizes.s10),
                                Text(appFonts.youCanChangeIt,
                                    style: AppCss.outfitMedium16
                                        .textColor(appCtrl.appTheme.lightText)),
                                const DottedLines()
                                    .paddingOnly(top: Insets.i20),
                                ...languageCtrl.selectLanguageLists
                                    .asMap()
                                    .entries
                                    .map((e) => RadioButtonLayout(
                                        data: e.value,
                                        selectIndex: languageCtrl.selectIndex,
                                        index: e.key,
                                        onTap: () => languageCtrl
                                            .onLanguageChange(e.key)))
                                    .toList()
                              ]).paddingSymmetric(
                              horizontal: Insets.i20, vertical: Insets.i25))
                      .authBoxExtension(),
                  ButtonCommon(
                      title: appFonts.continues,
                      onTap: () => Get.toNamed(routeName.selectCharacterScreen))
                ]).paddingSymmetric(
                horizontal: Insets.i20, vertical: Insets.i15)),
      );
    });
  }
}
