import '../../../../../config.dart';
import 'bottom_bar_item.dart';
import 'bottom_clipper.dart';
import 'clip_paths/clip_path1.dart';

class IconWidget extends StatelessWidget {
  final Animation<double>? animation;
  final Color? colorLayout;
  final BottomBarIconBuilder? iconBuilder;
  final Widget? iconData;

  const IconWidget(
      {Key? key,
      this.animation,
      this.colorLayout,
      this.iconBuilder,
      this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPathWidget(
            clipper: Clipper1(),
            animation: animation,
            iconBuilder: iconBuilder,
            iconData: iconData,
            colorLayout: colorLayout,
            clipperVal: 2),
        ClipPathWidget(
            clipper: Clipper2(),
            animation: animation,
            iconBuilder: iconBuilder,
            iconData: iconData,
            colorLayout: colorLayout,
            clipperVal: 3),
        ClipPathWidget(
            clipper: Clipper3(),
            animation: animation,
            iconBuilder: iconBuilder,
            iconData: iconData,
            colorLayout: colorLayout,
            clipperVal: 4),
        ClipPathWidget(
            clipper: Clipper4(),
            animation: animation,
            iconBuilder: iconBuilder,
            iconData: iconData,
            colorLayout: colorLayout,
            clipperVal: 5),
        ClipPathWidget(
            clipper: Clipper5(),
            animation: animation,
            iconBuilder: iconBuilder,
            iconData: iconData,
            colorLayout: colorLayout,
            clipperVal: 6),
      ],
    );
  }
}
