import 'dart:math';

import '../../../../../config.dart';

class BottomClipperLayout extends StatelessWidget {
  final bool? isNull,isSelect;
  final Animation<double>? animation;
  final Color? color;
  const BottomClipperLayout({Key? key,this.isNull,this.animation,this.isSelect,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:
      EdgeInsets.only(bottom: isNull! ? 10 : 0),
      child: AnimatedBuilder(
        animation: animation!,
        builder: (BuildContext context, Widget? child) {
          final scaleValue = animation!.value;

          final opacityValue = (-6.25 * pow(animation!.value, 2) +
              6.25 * animation!.value);

          return Opacity(
            opacity: isSelect!
                ? opacityValue > 1
                ? 1
                : opacityValue
                : 0,
            child: Transform.scale(
              scale: scaleValue,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: color!, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 50,
                height: 50,
              ),
            ),
          );
        },
      ),
    );
  }
}
