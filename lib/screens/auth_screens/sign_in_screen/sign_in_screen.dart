import 'package:flutter/services.dart';

import '../../../config.dart';

class SignInScreen extends StatelessWidget {
  final signInCtrl = Get.put(SignInController());

  SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (_) {
      return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
            backgroundColor: appCtrl.appTheme.bg1,
            appBar: const AppBarCommon(isArrow: false),
            body: ListView(children: [
              const VSpace(Sizes.s5),
              Form(
                      key: signInCtrl.signInGlobalKey,

                      child:
                          const SingleChildScrollView(child: SignInTextField()))
                  .paddingSymmetric(
                      horizontal: Insets.i20, vertical: Insets.i15),
              Text(appFonts.simplyUseThis.tr,
                      textAlign: TextAlign.center,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.lightText)
                          .textHeight(1.3))
                  .alignment(Alignment.bottomCenter)
                  .paddingSymmetric(
                      vertical: Insets.i40, horizontal: Insets.i20),
              if (signInCtrl.isLoading == true)
                const Center(child: CircularProgressIndicator())
            ]).height(MediaQuery.of(context).size.height)),
      );
    });
  }
}
