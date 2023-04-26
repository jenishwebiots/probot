
import '../config.dart';

class CommonAppWidgets {
  //column title and value
  Widget columnTitleAndValu(value, {title}) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      if (title != null)
        Text(title.toString().tr,
            textAlign: TextAlign.center,
            style: AppCss.outfitRegular14
                .textColor(appCtrl.appTheme.lightText)),
      if (title != null) const VSpace(Sizes.s3),
      Text(value.toString().tr,textAlign: TextAlign.center,
          style: AppCss.outfitRegular14.textColor(appCtrl.appTheme.txt))
    ],
  );
}