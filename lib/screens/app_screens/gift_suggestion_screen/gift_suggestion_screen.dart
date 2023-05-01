import '../../../config.dart';

class GiftSuggestionScreen extends StatelessWidget {
  final giftSuggestionCtrl = Get.put(GiftSuggestionController());

  GiftSuggestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftSuggestionController>(builder: (_) {
      return DirectionalityRtl(
        child: Scaffold(
            backgroundColor: appCtrl.appTheme.bg1,
            resizeToAvoidBottomInset: false,
            appBar: AppAppBarCommon(
                title: appFonts.giftSuggestion, leadingOnTap: () => Get.back()),
            body: Stack(
              children: [
                SingleChildScrollView(
                    child: giftSuggestionCtrl.isGiftSuggestionGenerate == true
                        ? Column(children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textCommon.outfitSemiBoldPrimary16(
                                      text: appFonts.discoverIncredible),
                                  const VSpace(Sizes.s15),
                                  InputLayout(
                                      hintText: "",
                                      title: appFonts.amazingGift,
                                      color: appCtrl.appTheme.white,
                                      isMax: false,
                                      text: giftSuggestionCtrl.response,
                                      responseText: giftSuggestionCtrl.response)
                                ]),
                            ButtonCommon(
                                    title: appFonts.endGiftIdeas,
                                    onTap: () =>
                                        giftSuggestionCtrl.endGiftSuggestion())
                                .paddingOnly(top: Insets.i30)
                          ]).paddingSymmetric(
                            vertical: Insets.i30, horizontal: Insets.i20)
                        : const WithoutGenerateResponseLayout()),
                if(giftSuggestionCtrl.isLoader == true) const LoaderLayout()
              ],
            )),
      );
    });
  }
}
