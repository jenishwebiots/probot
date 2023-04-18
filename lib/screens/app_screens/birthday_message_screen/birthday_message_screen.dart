import '../../../config.dart';

class BirthdayMessageScreen extends StatelessWidget {
  final birthdayCtrl = Get.put(BirthdayMessageController());

  BirthdayMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BirthdayMessageController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              title: appFonts.birthdayMessage, leadingOnTap: () => Get.back()),
          body: birthdayCtrl.isBirthdayGenerated == true
              ? Column(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textCommon.outfitSemiBoldPrimary16(
                            text: appFonts.aSpecialDay),
                        const VSpace(Sizes.s15),
                        InputLayout(
                            hintText: "",
                            title: appFonts.generatedWishes,
                            color: appCtrl.appTheme.white,
                            isMax: false,
                            controller:
                                birthdayCtrl.birthdayMessagesGenController)
                      ]),
                  const VSpace(Sizes.s20),
                  ButtonCommon(
                      title: appFonts.endBirthdayMessage,
                      onTap: () => birthdayCtrl.endNameSuggestion())
                ]).paddingSymmetric(
                  vertical: Insets.i30, horizontal: Insets.i20)
              : Column(children: [
                  Column(children: [
                    textCommon.outfitSemiBoldPrimary16(
                        text: appFonts.aSpecialDay),
                    const VSpace(Sizes.s15),
                    Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          textCommon.outfitSemiBoldTxt14(
                              text: appFonts.sendBirthdayWishes),
                          const VSpace(Sizes.s10),
                          TextFieldCommon(hintText: appFonts.enterValue),
                          const VSpace(Sizes.s20),
                          textCommon.outfitSemiBoldTxt14(text: appFonts.name),
                          const VSpace(Sizes.s10),
                          TextFieldCommon(hintText: appFonts.enterValue),
                          const VSpace(Sizes.s20),
                          MusicCategoryLayout(
                              title: appFonts.messageGenerateIn,
                              category: birthdayCtrl.selectItem ?? "Hindi",
                              onTap: () => birthdayCtrl.onLanguageSheet())
                        ])
                        .paddingSymmetric(
                            vertical: Insets.i20, horizontal: Insets.i15)
                        .authBoxExtension(),
                    const VSpace(Sizes.s30),
                    ButtonCommon(
                        title: appFonts.generateGoodWishes,
                        onTap: () => birthdayCtrl.onTapWishesGenerate())
                  ])
                ]).paddingSymmetric(
                  vertical: Insets.i30, horizontal: Insets.i20));
    });
  }
}
