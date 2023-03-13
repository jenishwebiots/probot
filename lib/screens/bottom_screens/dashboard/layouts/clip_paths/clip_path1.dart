import 'dart:math';

import 'package:probot/screens/bottom_screens/dashboard/layouts/bottom_widget.dart';

import '../../../../../../config.dart';
import '../bottom_bar_item.dart';

class ClipPathWidget extends StatelessWidget {
  final Animation<double>? animation;
  final Color? colorLayout;
  final BottomBarIconBuilder? iconBuilder;
  final Widget? iconData;
  final CustomClipper<Path>? clipper;
  final int? clipperVal;

  const ClipPathWidget(
      {Key? key,
      this.animation,
      this.colorLayout,
      this.iconBuilder,
      this.iconData,this.clipper,this.clipperVal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper:clipper,
        child: AnimatedBuilder(
            animation: animation!,
            builder: (BuildContext context, Widget? child) {
              var value = animation!.value * clipperVal!;
              value = value < 0 ? 0 : value;
              value = value > 1 ? 1 : value;
              final color = Color.lerp(
                  appCtrl.appTheme.primary, colorLayout!, value);

              final scaleValue =
                  -5 * (pow(animation!.value, 2) - animation!.value);
              return Transform.scale(
                  scale: scaleValue < 1 ? 1 : scaleValue,
                  child: BottomWidget().buildIconWidget(
                      color: color,
                      iconBuilder: iconBuilder,
                      iconData: iconData));
            }));
  }
}
