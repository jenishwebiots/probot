import 'dart:developer';

import '../../../../config.dart';

class LoginImageLayout extends StatelessWidget {
  const LoginImageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("height: ${MediaQuery.of(context).size.height}");
    return Stack(alignment: Alignment.bottomCenter, children: [
      SizedBox(
              height: MediaQuery.of(context).size.height < 534 ? MediaQuery.of(context).size.height * 0.37 : MediaQuery.of(context).size.height * 0.55,
              width: double.infinity,
              child: Image.asset(eImageAssets.lBg,height: MediaQuery.of(context).size.height * 0.35,fit: BoxFit.fill))
          .decorated(
              gradient: RadialGradient(
                  focalRadius: 1,
                  radius: 1,
                  colors: [
                    appCtrl.appTheme.primary,
                    appCtrl.appTheme.radialGradient
                  ],
                  center: const Alignment(-0.1, 0.1))),
      Image.asset(eImageAssets.loginBot, width: Sizes.s335, height: MediaQuery.of(context).size.height < 534 ? MediaQuery.of(context).size.height * 0.25 : MediaQuery.of(context).size.height * 0.4)
          .paddingOnly(bottom: Insets.i35)
    ]);
  }
}
