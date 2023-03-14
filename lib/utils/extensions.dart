import 'package:probot/config.dart';

extension ProbotExtensions on Widget {
  //Auth container extension
  Widget authBoxExtension() => Container(child: this)
      .decorated(
      color: appCtrl.appTheme.boxBg,
      boxShadow: [
        BoxShadow(
            color: appCtrl.isTheme ? appCtrl.appTheme.trans  : appCtrl.appTheme.primary.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4)
      ],
      borderRadius: const BorderRadius.all(
          Radius.circular(AppRadius.r10)),
      border: Border.all(
          color:  appCtrl.isTheme ? appCtrl.appTheme.trans  : appCtrl.appTheme.primary.withOpacity(0.1),
          width: 2));
}