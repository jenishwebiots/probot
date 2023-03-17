import '../../../../config.dart';

class ReceiverContent extends StatelessWidget {
  final String? text;
  const ReceiverContent({Key? key,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Insets.i10, vertical: Insets.i12),
        decoration: BoxDecoration(
            color: appCtrl.appTheme.boxBg,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(53, 193, 255, 0.06),
                  offset: Offset(0, 10),
                  blurRadius: 20)
            ],
            borderRadius:
            BorderRadius.circular(AppRadius.r6)),
        child: Text(
          text!,
          overflow: TextOverflow.clip,
          style: AppCss.outfitLight12
              .textColor(appCtrl.appTheme.txt)
              .textHeight(1.2),
        ));
  }
}