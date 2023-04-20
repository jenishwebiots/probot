import '../../../../config.dart';

class WeddingWishesLayout extends StatelessWidget {
  const WeddingWishesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeddingWishesController>(builder: (weddingWishesCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(text: appFonts.lovelyGreetings),
          const VSpace(Sizes.s20),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MusicCategoryLayout(
                title: appFonts.yearOfAnniversary,
                category: weddingWishesCtrl.onSelect ?? "20",
                onTap: () => weddingWishesCtrl.onWeddingAnniSheet()),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.relation),
            const VSpace(Sizes.s10),
            TextFieldCommon(hintText: appFonts.enterValue),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.name),
            const VSpace(Sizes.s10),
            TextFieldCommon(hintText: appFonts.enterValue),
            const VSpace(Sizes.s20),
            MusicCategoryLayout(
                title: appFonts.messageGenerateIn,
                category: weddingWishesCtrl.langOnSelect ?? "English",
                onTap: () => weddingWishesCtrl.onLanguageSheet())
          ])
              .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
              .authBoxExtension()
        ]),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.generateLovelyWishes,
            onTap: () => weddingWishesCtrl.onMessageGenerate())
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}