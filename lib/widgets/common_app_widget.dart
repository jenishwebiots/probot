
import '../config.dart';

class CommonAppWidgets{

  //column title and value
  Widget columnTitleAndValu(title,value)=> Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(title.toString().tr,
          style: AppCss.outfitRegular14
              .textColor(appCtrl.appTheme.lightText)),
      const VSpace(Sizes.s3),
      Text(value.toString().tr,
          style:
          AppCss.outfitRegular14.textColor(appCtrl.appTheme.txt))
    ],
  );
}