import '../../../../../config.dart';
import 'bottom_bar_item.dart';
import 'bubble_animated.dart';

class BottomBarBubbleLayout extends StatelessWidget {
  final int selectedIndex;
  final double height;
  final double? getLeftPosition;
  final double bubbleSize;
  final Color color;
  final List<BottomBarItem>? items;
  final List<Widget>? iconsWidget;

  const BottomBarBubbleLayout(
      {Key? key,
      this.items,
      this.selectedIndex = 0,
      this.height = 71,
      this.bubbleSize = 10,
      this.color = Colors.green,
      this.iconsWidget,
      this.getLeftPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardCtrl) {
      return SizedBox(
          height: height,
          child: Stack(children: [
            Row(children: iconsWidget!),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: (height - bubbleSize) / 2,
                curve: const Cubic(0.3, 0.6, 0.6, 0.3),
                left: getLeftPosition,
                child: BubbleAnimated(
                    animation: dashboardCtrl.animation,
                    bubbleSize: bubbleSize,
                    color: color,
                    offset: const Offset(0, 0),
                    size: bubbleSize * 0.9)),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                top: (height - bubbleSize) / 2,
                curve: const Cubic(0.3, 0.6, 0.6, 0.3),
                left: getLeftPosition! + 3,
                child: BubbleAnimated(
                    animation: dashboardCtrl.animation,
                    bubbleSize: bubbleSize,
                    color: color,
                    offset: const Offset(0, 13),
                    size: bubbleSize * 0.8)),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: const Cubic(0.3, 0.6, 0.6, 0.3),
                top: (height - bubbleSize) / 2,
                left: getLeftPosition! + 3,
                child: BubbleAnimated(
                    animation: dashboardCtrl.animation,
                    bubbleSize: bubbleSize,
                    color: color,
                    offset: const Offset(0, -10),
                    size: bubbleSize * 1.1)),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 450),
                top: (height - bubbleSize) / 2,
                curve: const Cubic(0.3, 0.6, 0.6, 0.3),
                left: getLeftPosition! - 3,
                child: BubbleAnimated(
                    animation: dashboardCtrl.animation,
                    bubbleSize: bubbleSize,
                    color: color,
                    offset: const Offset(0, -13),
                    size: bubbleSize * 0.85)),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: const Cubic(0.3, 0.6, 0.6, 0.3),
                top: (height - bubbleSize) / 2,
                left: getLeftPosition! - 3,
                child: BubbleAnimated(
                    animation: dashboardCtrl.animation,
                    bubbleSize: bubbleSize,
                    color: color,
                    offset: const Offset(0, -15),
                    size: bubbleSize * 0.9))
          ]));
    });
  }
}
