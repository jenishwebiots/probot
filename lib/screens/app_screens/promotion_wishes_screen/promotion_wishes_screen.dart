import '../../../config.dart';

class PromotionWishesScreen extends StatelessWidget {
  final promotionCtrl = Get.put(PromotionWishesController());

  PromotionWishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromotionWishesController>(builder: (_) {
      return DirectionalityRtl(
        child: Scaffold(
            backgroundColor: appCtrl.appTheme.bg1,
            resizeToAvoidBottomInset: false,
            appBar: AppAppBarCommon(
                title: appFonts.promotionWishes, leadingOnTap: () => Get.back()),
            body: Stack(
              children: [
                SingleChildScrollView(
                    child: promotionCtrl.isWishesGenerate == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                textCommon.outfitSemiBoldPrimary16(
                                    text: appFonts.salutationFor),
                                const VSpace(Sizes.s15),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InputLayout(
                                          hintText: "",
                                          title: appFonts.generatedWishes,
                                          color: appCtrl.appTheme.white,
                                          isMax: false,
                                          responseText: promotionCtrl.response),
                                      const VSpace(Sizes.s20),
                                      ButtonCommon(
                                          title: appFonts.endPromotionWish,
                                          onTap: () =>
                                              promotionCtrl.endWishGenerator())
                                    ])
                              ]).paddingSymmetric(
                            horizontal: Insets.i20, vertical: Insets.i30)
                        : const PromotionWishesLayout()),
                if(promotionCtrl.isLoader == true) const LoaderLayout()
              ],
            )),
      );
    });
  }
}
