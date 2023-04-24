import '../../../config.dart';

class NewYearGreetingScreen extends StatelessWidget {
  final newYearCtrl = Get.put(NewYearGreetingController());

  NewYearGreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewYearGreetingController>(builder: (_) {
      return DirectionalityRtl(
        child: Scaffold(
            backgroundColor: appCtrl.appTheme.bg1,
            resizeToAvoidBottomInset: false,
            appBar: AppAppBarCommon(
                title: appFonts.newYearGreeting, leadingOnTap: () => Get.back()),
            body: Stack(
              children: [
                SingleChildScrollView(
                    child: newYearCtrl.isGreetingGenerate == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                textCommon.outfitSemiBoldPrimary16(
                                    text: appFonts.dazzlingBestWishes),
                                const VSpace(Sizes.s15),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InputLayout(
                                          hintText: "",
                                          title: appFonts.newYearGreeting,
                                          color: appCtrl.appTheme.white,
                                          isMax: false,
                                          responseText: newYearCtrl.response),
                                      const VSpace(Sizes.s20),
                                      ButtonCommon(
                                          title: appFonts.endWellWishes,
                                          onTap: () =>
                                              newYearCtrl.endNewYearGreeting())
                                    ])
                              ]).paddingSymmetric(
                            horizontal: Insets.i20, vertical: Insets.i30)
                        : const NewYearGreetingLayout()),
                if(newYearCtrl.isLoader == true) const LoaderLayout()
              ],
            )),
      );
    });
  }
}
