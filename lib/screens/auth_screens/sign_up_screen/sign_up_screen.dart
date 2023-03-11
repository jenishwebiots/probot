import '../../../config.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    const VSpace(Sizes.s40),
                    Image.asset(eImageAssets.proBot,
                        height: Sizes.s38, width: Sizes.s130),
                    const VSpace(Sizes.s25),
                    SizedBox(
                            width: double.infinity,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(appFonts.createANewAccount,
                                      style: AppCss.outfitSemiBold22
                                          .textColor(appCtrl.appTheme.txt)),
                                  const VSpace(Sizes.s10),
                                  Text(appFonts.fillTheBelow,
                                      style: AppCss.outfitMedium16.textColor(
                                          appCtrl.appTheme.lightText)),
                                  const DottedLines().paddingOnly(
                                      top: Insets.i20, bottom: Insets.i15),
                                  Text(appFonts.email,
                                      style: AppCss.outfitMedium16
                                          .textColor(appCtrl.appTheme.txt)),
                                  const VSpace(Sizes.s10),
                                  TextFieldCommon(
                                      hintText: appFonts.enterEmail),
                                  const VSpace(Sizes.s15),
                                  Text(appFonts.password,
                                      style: AppCss.outfitMedium16
                                          .textColor(appCtrl.appTheme.txt)),
                                  const VSpace(Sizes.s10),
                                  TextFieldCommon(
                                      hintText: appFonts.enterPassword),
                                  const VSpace(Sizes.s15),
                                  Text(appFonts.confirmPassword,
                                      style: AppCss.outfitMedium16
                                          .textColor(appCtrl.appTheme.txt)),
                                  const VSpace(Sizes.s10),
                                  TextFieldCommon(
                                      hintText: appFonts.reEnterPassword),
                                  const VSpace(Sizes.s40),
                                  ButtonCommon(title: appFonts.signUp,onTap: ()=> Get.toNamed(routeName.selectLanguageScreen)),
                                  const VSpace(Sizes.s15),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                                text: appFonts
                                                    .alreadyHaveAnAccount,
                                                style: AppCss.outfitMedium16
                                                    .textColor(appCtrl
                                                        .appTheme.lightText),
                                                children: [
                                              TextSpan(
                                                  text: appFonts.signIn,
                                                  style: AppCss.outfitMedium16
                                                      .textColor(
                                                          appCtrl.appTheme.txt))
                                            ])).inkWell(onTap: ()=> Get.toNamed(routeName.signInScreen))
                                      ])
                                ]).paddingSymmetric(
                                horizontal: Insets.i20, vertical: Insets.i25))
                        .authBoxExtension()
                  ]),
                  Text(appFonts.simplyUseThis,
                      textAlign: TextAlign.center,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.lightText)
                          .textHeight(1.3))
                ]).paddingSymmetric(
                horizontal: Insets.i20, vertical: Insets.i15)));
  }
}
