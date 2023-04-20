import '../../../config.dart';


class FarewellMessageScreen extends StatelessWidget {
  final farewellCtrl = Get.put(FarewellMessageController());

  FarewellMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FarewellMessageController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              title: appFonts.farewellMessage, leadingOnTap: () => Get.back()),
          body: SingleChildScrollView(
            child: farewellCtrl.isMessageGenerate == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        textCommon.outfitSemiBoldPrimary16(
                            text: appFonts.aFewWishes),
                        const VSpace(Sizes.s15),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputLayout(
                                  hintText: "",
                                  title: appFonts.farewellMessage,
                                  color: appCtrl.appTheme.white,
                                  isMax: false,
                                  controller:
                                      farewellCtrl.messageGeneratedController),
                              const VSpace(Sizes.s20),
                              ButtonCommon(
                                  title: appFonts.endFarewellMessage,
                                  onTap: () => farewellCtrl.endWishGenerator())
                            ])
                      ]).paddingSymmetric(
                    horizontal: Insets.i20, vertical: Insets.i30)
                : const FarewellMessageLayout(),
          ));
    });
  }
}
