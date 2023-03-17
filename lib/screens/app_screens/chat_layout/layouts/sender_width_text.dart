

import '../../../../config.dart';

class SenderWidthText extends StatelessWidget {
  final String? text;
  const SenderWidthText({Key? key,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(
          horizontal: Insets.i10, vertical: Insets.i12),
      decoration: BoxDecoration(
          color: appCtrl.appTheme.boxBg,
          borderRadius:
          BorderRadius.circular(AppRadius.r6)),
      child: Text(
        text!,
        overflow: TextOverflow.clip,
        style: AppCss.outfitMedium14
            .textColor(appCtrl.appTheme.txt)
            .textHeight(1.2),
      ),
    );
  }
}
