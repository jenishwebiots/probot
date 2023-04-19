import '../../../../config.dart';

class GetWellMessageLayout extends StatelessWidget {
  const GetWellMessageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetWellMessageController>(
      builder: (getCtrl) {
        return Column(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textCommon.outfitSemiBoldPrimary16(text: appFonts.sendingBestWishes),
            const VSpace(Sizes.s15),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                  text: TextSpan(
                      text: appFonts.wellWishes,
                      style:
                          AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt),
                      children: [
                    TextSpan(
                        text: " (${appFonts.name.tr})",
                        style: AppCss.outfitSemiBold14
                            .textColor(appCtrl.appTheme.lightText))
                  ])),
              const VSpace(Sizes.s10),
              TextFieldCommon(hintText: appFonts.enterValue),
              const VSpace(Sizes.s20),
              textCommon.outfitSemiBoldTxt14(text: appFonts.relation),
              const VSpace(Sizes.s10),
              TextFieldCommon(hintText: appFonts.enterValue),
              const VSpace(Sizes.s20),
              textCommon.outfitSemiBoldTxt14(text: appFonts.whatHappened),
              const VSpace(Sizes.s10),
              TextFieldCommon(hintText: appFonts.enterValue)
            ])
                .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
                .authBoxExtension()
          ]),
          const VSpace(Sizes.s30),
          ButtonCommon(
              title: appFonts.generateHealthWishes,
              onTap: () => getCtrl.onWellMessageGenerate())
        ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
      }
    );
  }
}
