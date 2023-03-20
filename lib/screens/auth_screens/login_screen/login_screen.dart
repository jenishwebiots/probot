import 'package:flutter/services.dart';

import '../../../config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body:
            Column( children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                      height: Sizes.s450,
                      width: double.infinity,
                      child: Image.asset(eImageAssets.lBg, fit: BoxFit.cover))
                  .decorated(
                      gradient: RadialGradient(
                          focalRadius: 1,
                          radius: 1,
                          colors: [
                            appCtrl.appTheme.primary,
                            appCtrl.appTheme.radialGradient
                          ],
                          center: const Alignment(-0.1, 0.1))),
              Image.asset(eImageAssets.loginBot,width: Sizes.s335).paddingOnly(bottom: Insets.i35)
            ]
          ),
          const VSpace(Sizes.s20),
          Column(children: [
            IntrinsicHeight(
                child: Row(children: [
              VerticalDivider(
                      thickness: 4, width: 1, color: appCtrl.appTheme.primary)
                  .backgroundColor(appCtrl.appTheme.error),
              const HSpace(Sizes.s12),
              SizedBox(
                  width: Sizes.s300,
                  child: Text(appFonts.fastResponse.tr,
                      style: AppCss.outfitSemiBold22
                          .textColor(appCtrl.appTheme.txt)
                          .textHeight(1.3)))
            ])),
            const VSpace(Sizes.s20),
            Text(appFonts.aBuddyWhoAvailable.tr,
                style: AppCss.outfitMedium16
                    .textColor(appCtrl.appTheme.lightText)
                    .textHeight(1.3)),
            const VSpace(Sizes.s40),
            Row(children: [
              Expanded(child: ButtonCommon(title: appFonts.signUp,onTap: ()=> Get.toNamed(routeName.signUpScreen))),
              const HSpace(Sizes.s15),
              Expanded(child: ButtonCommon(title: appFonts.signIn,onTap: ()=> Get.toNamed(routeName.signInScreen)))
            ]),
            const OrLayout(),
            Text(appFonts.continueAsAGuest.tr,
                style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.primary)).inkWell(onTap: (){
                 appCtrl.isLogin = true;
                  appCtrl.storage.write("isLogin", appCtrl.isLogin);
                  Get.offAllNamed(routeName.dashboard);
            })
          ]).paddingSymmetric(horizontal: Insets.i20)
        ]).paddingOnly(bottom: Insets.i10)
      ),
    );
  }
}
