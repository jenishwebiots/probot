import '../../../config.dart';


class FathersDayWishesScreen extends StatelessWidget {
  final fatherCtrl = Get.put(FathersDayWishesController());

  FathersDayWishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FathersDayWishesController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              title: appFonts.fathersDayWishes, leadingOnTap: () => Get.back()),
          body: SingleChildScrollView(
              child: fatherCtrl.isWishesGenerate == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          textCommon.outfitSemiBoldPrimary16(
                              text: appFonts.warmestRegards),
                          const VSpace(Sizes.s15),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InputLayout(
                                    hintText: "",
                                    title: appFonts.fathersDayWishes,
                                    color: appCtrl.appTheme.white,
                                    isMax: false,
                                    controller:
                                        fatherCtrl.wishGeneratedController),
                                const VSpace(Sizes.s20),
                                ButtonCommon(
                                    title: appFonts.endFathersDay,
                                    onTap: () => fatherCtrl.endWishGenerator())
                              ])
                        ]).paddingSymmetric(
                      horizontal: Insets.i20, vertical: Insets.i30)
                  : const FathersDayWishesLayout()));
    });
  }
}
