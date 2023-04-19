import '../config.dart';

class TextCommon {
  outfitSemiBoldPrimary16({text}) {
    return Text(text.toString().tr,
        style: AppCss.outfitBold16.textColor(appCtrl.appTheme.primary));
  }

  outfitSemiBoldTxt14({text}) {
    return Text(text.toString().tr,
        style: AppCss.outfitBold14.textColor(appCtrl.appTheme.txt));
  }
}