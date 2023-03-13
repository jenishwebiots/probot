

import '../../../../../config.dart';
import 'bottom_bar_item.dart';

class BottomWidget{

  Widget indicator(isSelected) => AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    height: Sizes.s3,
    width: Sizes.s30,
    decoration: BoxDecoration(
        color: isSelected
            ? appCtrl.appTheme.primary
            : appCtrl.appTheme.lightText),
  );

  //icon widget
  Widget iconWidget({Widget? child,isNull}) => Positioned(
      bottom: isNull ? 10 : 0,
      top: 0,
      left: 0,
      right: 0,
      child: child!);

  Widget buildIconWidget({Color? color,  BottomBarIconBuilder? iconBuilder,Widget? iconData}) {
    if (iconBuilder != null) {
      return Padding(
          padding: const EdgeInsets.all(10),
          child: iconBuilder.call(color!));
    } else {
      return iconData!;
    }
  }
}