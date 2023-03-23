import '../../../config.dart';

class SignUpScreen extends StatelessWidget {
  final signUpCtrl = Get.put(SignUpController());

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (_) {
      return Scaffold(
          appBar: const AppBarCommon(isArrow: false),
          body: Stack(alignment: Alignment.center, children: [
            ListView(children: [
              const VSpace(Sizes.s5),
              SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: signUpCtrl.signUpGlobalKey,
                    child: const SignUpField(),
                  )).authBoxExtension(),
              Text(appFonts.simplyUseThis.tr,
                      textAlign: TextAlign.center,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.lightText)
                          .textHeight(1.3))
                  .alignment(Alignment.bottomCenter)
                  .paddingSymmetric(
                      vertical: Insets.i40, horizontal: Insets.i10),
              if (signUpCtrl.isLoading == true)
                const Center(child: CircularProgressIndicator())
            ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i15)
          ]));
    });
  }
}
