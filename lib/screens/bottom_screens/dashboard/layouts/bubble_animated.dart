import '../../../../../config.dart';
import 'bubble_widget.dart';

class BubbleAnimated extends StatelessWidget {
  final double bubbleSize;
  final Color? color;
  final Animation<double?>? animation;
  final Offset? offset;
  final double? size;

  const BubbleAnimated(
      {Key? key,
      this.bubbleSize = 10,
      this.color,
      this.animation,
      this.offset,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation!,
        builder: (BuildContext context, Widget? child) {
          return BubbleWidget(
              animation: animation, color: color, size: size, offset: offset);
        });
  }
}
