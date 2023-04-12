import '../../../../config.dart';

class EmailGeneratorTopLayout extends StatelessWidget {
  const EmailGeneratorTopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(children: [
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appFonts.writeFrom,
                    style: AppCss.outfitSemiBold14
                        .textColor(appCtrl.appTheme.txt)),
                const VSpace(Sizes.s10),
                TextFieldCommon(hintText: appFonts.enterValue)
              ])),
      const HSpace(Sizes.s15),
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appFonts.writeTo,
                    style: AppCss.outfitSemiBold14
                        .textColor(appCtrl.appTheme.txt)),
                const VSpace(Sizes.s10),
                TextFieldCommon(hintText: appFonts.enterValue)
              ]))
    ]);
  }
}
