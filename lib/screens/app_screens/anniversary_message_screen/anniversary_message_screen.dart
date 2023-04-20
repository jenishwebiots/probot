import '../../../config.dart';

class AnniversaryMessageScreen extends StatelessWidget {
  final anniCtrl = Get.put(AnniversaryMessageController());

  AnniversaryMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnniversaryMessageController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              title: appFonts.anniversaryMessage,
              leadingOnTap: () => Get.back()),
          body: SingleChildScrollView(
              child: anniCtrl.isMessageGenerate == true
                  ? Column(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textCommon.outfitSemiBoldPrimary16(
                                text: appFonts.goodWishesOn),
                            const VSpace(Sizes.s15),
                            InputLayout(
                                hintText: "",
                                title: appFonts.generatedWishes,
                                color: appCtrl.appTheme.white,
                                isMax: false,
                                responseText: anniCtrl.response),
                            const VSpace(Sizes.s20),
                            ButtonCommon(
                                title: appFonts.endAnniversaryMessage,
                                onTap: () => anniCtrl.endNameSuggestion())
                          ])
                    ]).paddingSymmetric(
                      vertical: Insets.i30, horizontal: Insets.i20)
                  : const AnniversaryMessageLayout()));
    });
  }
}
