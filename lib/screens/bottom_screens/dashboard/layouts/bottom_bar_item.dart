

import '../../../../../config.dart';

typedef BottomBarIconBuilder = Widget Function(Color color);

class BottomBarItem {
  final Widget? iconData;
  final double iconSize;
  final String? label;
  final TextStyle? labelTextStyle;
  final double labelMarginTop;
  final BottomBarIconBuilder? iconBuilder;

  BottomBarItem({
    this.iconData,
    this.iconSize = 30,
    this.label,
    this.iconBuilder,
    this.labelMarginTop = 0,
    this.labelTextStyle,
  }) : assert(iconData != null || iconBuilder != null);
}