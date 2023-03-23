import 'package:flutter/services.dart';
import '../../../config.dart';

class SelectLanguageScreen extends StatelessWidget {
  final languageCtrl = Get.put(SelectLanguageController());
  SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectLanguageController>(builder: (_) {
      return WillPopScope(
        onWillPop: () async{
          if(languageCtrl.isBack){
            Get.back();
          }else {
            SystemNavigator.pop();
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: const AppBarCommon(isSystemNavigate: false),
          body: ListView(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appFonts.selectLanguage.tr,
                        style: AppCss.outfitSemiBold22
                            .textColor(appCtrl.appTheme.txt)),
                    const VSpace(Sizes.s10),
                    Text(appFonts.youCanChangeIt.tr,
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
                            onTap: ()=> languageCtrl.onLanguageSelectTap(e.key, e.value)))
                        .toList()

                  ]).paddingSymmetric(
                  horizontal: Insets.i20, vertical: Insets.i25)
                  .authBoxExtension(),
              ButtonCommon(
                  title: appFonts.continues,
                  onTap: () =>languageCtrl.onContinue()).paddingSymmetric(vertical: Insets.i20)
            ]
          ).paddingSymmetric(
              horizontal: Insets.i20, vertical: Insets.i15)
        )
      );
    });
  }
}
