import '../../../config.dart';
import '../../../widgets/validation.dart';

class SignUpScreen extends StatelessWidget {
  final signUpCtrl = Get.put(SignUpController());
  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (_) {
      return Scaffold(
        appBar: const AppBarCommon(isArrow: false),
          body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Form(
                        key: signUpCtrl.signUpGlobalKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(appFonts.createANewAccount.tr,
                                  style: AppCss.outfitSemiBold22
                                      .textColor(appCtrl.appTheme.txt)),
                              const VSpace(Sizes.s10),
                              Text(appFonts.fillTheBelow.tr,
                                  style: AppCss.outfitMedium16.textColor(
                                      appCtrl.appTheme.lightText)),
                              const DottedLines().paddingOnly(
                                  top: Insets.i20, bottom: Insets.i15),
                              Text(appFonts.email.tr,
                                  style: AppCss.outfitMedium16
                                      .textColor(appCtrl.appTheme.txt)),
                              const VSpace(Sizes.s10),
                              TextFieldCommon(
                                  validator: (email) =>
                                      Validation().emailValidation(email),
                                  controller: signUpCtrl.emailController,
                                  hintText: appFonts.enterEmail.tr),
                              const VSpace(Sizes.s15),
                              Text(appFonts.password.tr,
                                  style: AppCss.outfitMedium16
                                      .textColor(appCtrl.appTheme.txt)),
                              const VSpace(Sizes.s10),
                              TextFieldCommon(
                                  validator: (password) =>
                                      Validation().passValidation(password),
                                  controller: signUpCtrl.passwordController,
                                  hintText: appFonts.enterPassword.tr),
                              const VSpace(Sizes.s15),
                              Text(appFonts.confirmPassword.tr,
                                  style: AppCss.outfitMedium16
                                      .textColor(appCtrl.appTheme.txt)),
                              const VSpace(Sizes.s10),
                              TextFieldCommon(
                                  validator: (cfm) {
                                    if (signUpCtrl
                                            .passwordController.text !=
                                        signUpCtrl.confirmPasswordController
                                            .text) {
                                      return appFonts.passwordNotSame.tr;
                                    }
                                    if (cfm!.isEmpty) {
                                      return appFonts.pleaseEnterPassword.tr;
                                    }
                                    return null;
                                  },
                                  controller:
                                      signUpCtrl.confirmPasswordController,
                                  hintText: appFonts.reEnterPassword.tr),
                              const VSpace(Sizes.s40),
                              ButtonCommon(
                                  title: appFonts.signUp,
                                  onTap: () => signUpCtrl.signUpMethod()),
                              const VSpace(Sizes.s15),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            text: appFonts
                                                .alreadyHaveAnAccount.tr,
                                            style: AppCss.outfitMedium16
                                                .textColor(appCtrl
                                                    .appTheme.lightText),
                                            children: [
                                          TextSpan(
                                              text: appFonts.signIn.tr,
                                              style: AppCss.outfitMedium16
                                                  .textColor(
                                                      appCtrl.appTheme.txt))
                                        ])).inkWell(
                                        onTap: () => Get.toNamed(
                                            routeName.signInScreen))
                                  ])
                            ]).paddingSymmetric(
                            horizontal: Insets.i20, vertical: Insets.i25),
                      )).authBoxExtension(),
                  Text(appFonts.simplyUseThis.tr,
                      textAlign: TextAlign.center,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.lightText)
                          .textHeight(1.3))
                ]).paddingSymmetric(
                horizontal: Insets.i20, vertical: Insets.i15),
          ),
          if (signUpCtrl.isLoading == true)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ));
    });
  }
}
