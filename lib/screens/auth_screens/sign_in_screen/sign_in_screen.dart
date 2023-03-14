import 'package:flutter/services.dart';

import '../../../config.dart';

class SignInScreen extends StatelessWidget {
  final signInCtrl = Get.put(SignInController());

  SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (_) {
      return WillPopScope(
        onWillPop: () async{
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
            appBar: const AppBarCommon(isArrow: false),
            body: ListView( children: [
              const VSpace(Sizes.s5),
              Form(
                  key: signInCtrl.signInGlobalKey,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(appFonts.welcomeBack.tr,
                              style: AppCss.outfitSemiBold22
                                  .textColor(appCtrl.appTheme.txt)),
                          const VSpace(Sizes.s10),
                          Text(appFonts.fillTheBelow.tr,
                              style: AppCss.outfitMedium16
                                  .textColor(
                                      appCtrl.appTheme.lightText)),
                          const DottedLines().paddingOnly(
                              top: Insets.i20, bottom: Insets.i15),
                          Text(appFonts.email.tr,
                              style: AppCss.outfitMedium16
                                  .textColor(appCtrl.appTheme.txt)),
                          const VSpace(Sizes.s10),
                          TextFieldCommon(
                              validator: (email) => Validation()
                                  .emailValidation(email),
                              controller:
                                  signInCtrl.emailController,
                              hintText: appFonts.enterEmail.tr),
                          const VSpace(Sizes.s15),
                          Text(appFonts.password.tr,
                              style: AppCss.outfitMedium16
                                  .textColor(appCtrl.appTheme.txt)),
                          const VSpace(Sizes.s10),
                          TextFieldCommon(
                              suffixIcon: SvgPicture.asset(
                                      signInCtrl.obscureText
                                          ? eSvgAssets.eyeSlash
                                          : eSvgAssets.eye,fit: BoxFit.scaleDown,)
                                  .inkWell(
                                      onTap: () =>
                                          signInCtrl.onObscure()),
                              obscureText: signInCtrl.obscureText,
                              validator: (password) => Validation()
                                  .passValidation(password),
                              controller:
                                  signInCtrl.passwordController,
                              hintText: appFonts.enterPassword.tr),
                          const VSpace(Sizes.s10),
                          Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.end,
                              children: [
                                Text(appFonts.resetPassword.tr,
                                        style: AppCss.outfitMedium14
                                            .textColor(appCtrl
                                                .appTheme.primary))
                                    .inkWell(
                                        onTap: () => Get.toNamed(
                                            routeName
                                                .restPasswordScreen))
                              ]),
                          const VSpace(Sizes.s40),
                          ButtonCommon(
                              title: appFonts.signIn,
                              onTap: () =>
                                  signInCtrl.signInMethod()),
                          const VSpace(Sizes.s15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: appFonts
                                            .dontHaveAnAccount.tr,
                                        style: AppCss
                                            .outfitMedium16
                                            .textColor(appCtrl
                                                .appTheme
                                                .lightText),
                                        children: [
                                      TextSpan(
                                          text:
                                              appFonts.signUp.tr,
                                          style: AppCss
                                              .outfitMedium16
                                              .textColor(appCtrl
                                                  .appTheme.txt))
                                    ])).inkWell(
                                    onTap: () => Get.toNamed(
                                        routeName.signUpScreen))
                              ]),
                          const OrLayout().alignment(Alignment.center),
                          ButtonCommon(
                              isGradient: false,
                              color: appCtrl.appTheme.boxBg,
                              style: AppCss.outfitMedium16
                                  .textColor(appCtrl.appTheme.txt),
                              onTap: () =>
                                  signInCtrl.signInWithGoogle(),
                              title: appFonts.continueWithGoogle,
                              icon: Image.asset(eImageAssets.google,
                                  height: 20, width: 20))
                        ]).paddingSymmetric(
                        horizontal: Insets.i20,
                        vertical: Insets.i25)
                        .authBoxExtension(),
                  )).paddingSymmetric(
                  horizontal: Insets.i20, vertical: Insets.i15),
              Text(appFonts.simplyUseThis.tr,
                  textAlign: TextAlign.center,
                  style: AppCss.outfitMedium16
                      .textColor(appCtrl.appTheme.lightText)
                      .textHeight(1.3)).alignment(Alignment.bottomCenter).paddingSymmetric(vertical: Insets.i40,horizontal: Insets.i20),
              if (signInCtrl.isLoading == true)
                const Center(child: CircularProgressIndicator())
            ]).height(MediaQuery.of(context).size.height)),
      );
    });
  }
}
