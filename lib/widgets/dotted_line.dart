import '../config.dart';


class DottedLines extends StatelessWidget {
  const DottedLines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 1,
        dashLength: 3,
        dashColor: appCtrl.appTheme.lightText);
  }
}
