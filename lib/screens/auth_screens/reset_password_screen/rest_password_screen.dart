import '../../../config.dart';

class RestPasswordScreen extends StatelessWidget {
  final resetPasswordCtrl = Get.put(ResetPasswordController());

  RestPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(builder: (_) {
      return Scaffold(
          body: Stack(alignment: Alignment.center, children: [
        Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    const VSpace(Sizes.s40),
                    Image.asset(eImageAssets.proBot,
                        height: Sizes.s38, width: Sizes.s130),
                    const VSpace(Sizes.s25),
                    Form(
                        key: resetPasswordCtrl.resetPasswordGlobalKey,
                        child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(appFonts.resetPassword,
                                          style: AppCss.outfitSemiBold22
                                              .textColor(appCtrl.appTheme.txt)),
                                      const VSpace(Sizes.s10),
                                      Text(appFonts.enterYourMailOr,
                                          style: AppCss.outfitMedium16
                                              .textColor(
                                                  appCtrl.appTheme.lightText)),
                                      const DottedLines().paddingOnly(
                                          top: Insets.i20, bottom: Insets.i15),
                                      Text(appFonts.email,
                                          style: AppCss.outfitMedium16
                                              .textColor(appCtrl.appTheme.txt)),
                                      const VSpace(Sizes.s10),
                                      TextFieldCommon(
                                          validator: (email) => Validation()
                                              .emailValidation(email),
                                          controller:
                                              resetPasswordCtrl.emailController,
                                          hintText: appFonts.enterEmail),
                                      const VSpace(Sizes.s40),
                                      ButtonCommon(
                                          title: appFonts.resetPassword,
                                          onTap: () => resetPasswordCtrl
                                              .onResetPassword())
                                    ]).paddingSymmetric(
                                    horizontal: Insets.i20,
                                    vertical: Insets.i25))
                            .authBoxExtension())
                  ]),
                  Text(appFonts.simplyUseThis,
                      textAlign: TextAlign.center,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.lightText)
                          .textHeight(1.3))
                ]).paddingSymmetric(
                horizontal: Insets.i20, vertical: Insets.i15)),
        if (resetPasswordCtrl.isLoading == true)
          const Center(child: CircularProgressIndicator())
      ]));
    });
  }
}
