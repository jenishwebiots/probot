import 'package:flutter/services.dart';


import '../../../config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          body: Column(children: [
        Stack(alignment: Alignment.bottomCenter, children: [
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
          Image.asset(eImageAssets.loginBot, width: Sizes.s335)
              .paddingOnly(bottom: Insets.i35)
        ]),
        const VSpace(Sizes.s20),
        const LoginBody().paddingSymmetric(horizontal: Insets.i20)
      ]).paddingOnly(bottom: Insets.i10)),
    );
  }
}
