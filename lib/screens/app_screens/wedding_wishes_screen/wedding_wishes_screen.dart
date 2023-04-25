import '../../../config.dart';

class WeddingWishesScreen extends StatelessWidget {
  final weddingWishesCtrl = Get.put(WeddingWishesController());

  WeddingWishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeddingWishesController>(builder: (_) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              title: appFonts.weddingWishes, leadingOnTap: () => Get.back()),
          body: Stack(
            children: [
              SingleChildScrollView(
                  child: weddingWishesCtrl.isWeddingWishGenerate == true
                      ? Column(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textCommon.outfitSemiBoldPrimary16(
                                    text: appFonts.lovelyGreeting),
                                const VSpace(Sizes.s15),
                                InputLayout(
                                    hintText: "",
                                    title: appFonts.generatedWishes,
                                    color: appCtrl.appTheme.white,
                                    isMax: false,
                                    responseText: weddingWishesCtrl.response),
                                const VSpace(Sizes.s20),
                                ButtonCommon(
                                    title: appFonts.endWeddingWishes,
                                    onTap: () =>
                                        weddingWishesCtrl.endWeddingWishes())
                              ])
                        ]).paddingSymmetric(
                          vertical: Insets.i30, horizontal: Insets.i20)
                      : const WeddingWishesLayout()),
              if(weddingWishesCtrl.isLoader == true) const LoaderLayout()
            ],
          ));
    });
  }
}
