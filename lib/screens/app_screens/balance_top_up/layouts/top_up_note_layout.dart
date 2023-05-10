import '../../../../config.dart';

class TopUpNoteLayout extends StatelessWidget {
  final String? title;
  const TopUpNoteLayout({Key? key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.circle,
          color: appCtrl.appTheme.primary, size: Sizes.s5),
      const HSpace(Sizes.s5),
      Text(title!.toString().tr,
          style: AppCss.outfitRegular14
              .textColor(appCtrl.appTheme.primary))
    ]);
  }
}
