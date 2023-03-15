
import '../../../../config.dart';

class ChatCommonWidget{

  //social layout
  Widget socialLayout(image,text)=> Column(
    children: [
      SvgPicture.asset(image,height: Sizes.s60,),
      const VSpace(Sizes.s8),
      Text(text,
          style: AppCss.outfitMedium14
              .textColor(appCtrl.appTheme.txt)
              .textDecoration(TextDecoration.none))
    ],
  );
}