import '../../../config.dart';

class BabyNameScreen extends StatelessWidget {
  final babyCtrl = Get.put(BabyNameSuggestionController());

  BabyNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BabyNameSuggestionController>(builder: (_) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              title: appFonts.babyNameSuggestion,
              leadingOnTap: () => Get.back()),
          body: Column(children: [
            babyCtrl.isNameGenerate == false
                ? const BabyNameTopLayout()
                : Column(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textCommon.outfitSemiBoldPrimary16(
                              text: appFonts.someCuteNames),
                          const VSpace(Sizes.s15),
                          InputLayout(
                              hintText: "",
                              title: appFonts.babyName,
                              color: appCtrl.appTheme.white,
                              isMax: false,
                              controller: babyCtrl.generatedNameController)
                        ]),
                    const VSpace(Sizes.s20),
                    ButtonCommon(
                        title: appFonts.endNameSuggestion,
                        onTap: () => babyCtrl.endNameSuggestion())
                  ])
          ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20));
    });
  }
}
