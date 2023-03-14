import 'package:flutter/services.dart';

import '../../../config.dart';

class AddFingerprintScreen extends StatelessWidget {
  const AddFingerprintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async{
        SystemNavigator.pop();
        return true;

      },
      child: Scaffold(
        appBar: const AppBarCommon(isSystemNavigate: false),
        body: Container(
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(eImageAssets.addFinger, height: 360, width: 270),
                    const VSpace(Sizes.s10),
                    Text(
                      appFonts.setupAFingerprint.tr,
                      textAlign: TextAlign.center,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.txt)
                          .textHeight(1.3),
                    ),
                  ],
                ),
                Column(children: [
                  ButtonCommon(title: appFonts.addNow),
                  const VSpace(Sizes.s10),
                  ButtonCommon(
                    onTap: ()=> Get.toNamed(routeName.dashboard),
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.primary),
                      title: appFonts.doItLater,
                      color: appCtrl.appTheme.trans)
                ])
              ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i20),
        ),
      ),
    );
  }
}
