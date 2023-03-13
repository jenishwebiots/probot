import 'dart:math';

import '../../../../../config.dart';

class BubbleWidget extends StatelessWidget {
  final Animation<double?>? animation;
  final Offset? offset;
  final double? size;
  final Color? color;
  const BubbleWidget({Key? key,this.animation,this.size,this.offset,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = animation!.value;
    final scaleValue = -4 * (pow(value!, 2) - value);
    return Transform.scale(
      scale: scaleValue,
      child: Transform.translate(
        offset: offset!,
        child: ClipOval(
          child: Container(
            color: color,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
