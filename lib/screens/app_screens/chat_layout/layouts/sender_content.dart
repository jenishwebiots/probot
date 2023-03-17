import '../../../../config.dart';

class CommonContent extends StatelessWidget {
  final String? text;
  const CommonContent({Key? key,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Insets.i10, vertical: Insets.i12),
      decoration: BoxDecoration(
          color: appCtrl.appTheme.primary,
          borderRadius: BorderRadius.circular(AppRadius.r6)),
      child: Text(
        text!,
        style: AppCss.outfitMedium14
            .textColor(appCtrl.appTheme.sameWhite),
      ),
    );
  }
}
