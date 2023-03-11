import 'package:probot/controllers/auth_controllers/select_language_controller.dart';

import '../../../config.dart';

class SelectLanguageScreen extends StatelessWidget {
  final languageCtrl = Get.put(SelectLanguageController());
  SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectLanguageController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: appCtrl.appTheme.bg1,
            elevation: 0,
            leading: SvgPicture.asset(eSvgAssets.leftArrow, fit: BoxFit.scaleDown),
            title: Image.asset(eImageAssets.proBot, height: Sizes.s38, width: Sizes.s130)
          ),
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
                                  style: AppCss.outfitMedium16.textColor(
                                      appCtrl.appTheme.lightText)),
                              const DottedLines().paddingOnly(
                                  top: Insets.i20, bottom: Insets.i15),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Row(
                                     children: [
                                              Image.asset(eImageAssets.english,height: Sizes.s40,width: Sizes.s40),
                                       const HSpace(Sizes.s12),
                                       Text(appFonts.english,style: AppCss.outfitMedium18.textColor(appCtrl.appTheme.txt))
                                     ]
                                   ),
                                   Stack(
                                     alignment: Alignment.center,
                                     children: const [
                                       Icon(Icons.circle_outlined),
                                       Icon(Icons.circle,size: 11)
                                     ],
                                   ),
                                 ],
                               )
                            ]).paddingSymmetric(
                            horizontal: Insets.i20, vertical: Insets.i25))
                        .authBoxExtension(),
                  ]).paddingSymmetric(
                  horizontal: Insets.i20, vertical: Insets.i15)),
        );
      }
    );
  }
}
