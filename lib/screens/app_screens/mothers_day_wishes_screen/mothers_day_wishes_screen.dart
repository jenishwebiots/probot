import '../../../config.dart';

class MothersDayWishesScreen extends StatelessWidget {
  final motherDayCtrl = Get.put(MothersDayWishesController());

  MothersDayWishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MothersDayWishesController>(builder: (_) {
      return DirectionalityRtl(
        child: Scaffold(
            backgroundColor: appCtrl.appTheme.bg1,
            resizeToAvoidBottomInset: false,
            appBar: AppAppBarCommon(
                title: appFonts.mothersDayWishes, leadingOnTap: () => Get.back()),
            body: Stack(
              children: [
                SingleChildScrollView(
                    child: motherDayCtrl.isWishesGenerate == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                textCommon.outfitSemiBoldPrimary16(
                                    text: appFonts.heartfeltWishes),
                                const VSpace(Sizes.s15),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InputLayout(
                                          hintText: "",
                                          title: appFonts.mothersDayWishes,
                                          color: appCtrl.appTheme.white,
                                          isMax: false,
                                          responseText: motherDayCtrl.response),
                                      const VSpace(Sizes.s20),
                                      ButtonCommon(
                                          title: appFonts.endMotherDay,
                                          onTap: () =>
                                              motherDayCtrl.endWishGenerator())
                                    ])
                              ]).paddingSymmetric(
                            horizontal: Insets.i20, vertical: Insets.i30)
                        : const MothersDayWishesLayout()),
                if(motherDayCtrl.isLoader == true) const LoaderLayout()
              ],
            )),
      );
    });
  }
}
