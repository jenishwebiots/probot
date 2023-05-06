import '../../../../config.dart';

class GeneratedMailLayout extends StatelessWidget {
  const GeneratedMailLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailGeneratorController>(builder: (emailGeneratorCtrl) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(appFonts.toGetTheExcellent.tr,
                  style: AppCss.outfitSemiBold16
                      .textColor(appCtrl.appTheme.primary)),
              const VSpace(Sizes.s15),
              SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    EmailGeneratorTopLayout(
                        fTitle: appFonts.writeFrom,
                        fHint: appFonts.enterValue,
                        fController: emailGeneratorCtrl.writeFromController,
                        sTitle: appFonts.writeTo,
                        sHint: appFonts.enterValue,
                        sController: emailGeneratorCtrl.writeToController),
                    const VSpace(Sizes.s20),
                    Text(appFonts.topic.tr,
                        style: AppCss.outfitSemiBold14
                            .textColor(appCtrl.appTheme.txt)),
                    const VSpace(Sizes.s10),
                    TextFieldCommon(
                        controller: emailGeneratorCtrl.topicController,
                        hintText: appFonts.typeHere,
                        minLines: 8,
                        maxLines: 8,
                        fillColor: appCtrl.appTheme.textField,
                        keyboardType: TextInputType.multiline),
                    const VSpace(Sizes.s20),
                    Text(appFonts.tone.tr,
                        style: AppCss.outfitSemiBold14
                            .textColor(appCtrl.appTheme.txt)),
                    Wrap(
                        children: emailGeneratorCtrl.toneLists
                            .asMap()
                            .entries
                            .map((e) => ToneLayout(
                                title: e.value,
                                index: e.key,
                                selectedIndex: emailGeneratorCtrl.selectIndex,
                                onTap: () => emailGeneratorCtrl
                                    .onToneChange(e.key)).paddingOnly(
                                top: Insets.i10, right: Insets.i10))
                            .toList()),
                    const VSpace(Sizes.s20),
                    Text(appFonts.mailLength.tr,
                        style: AppCss.outfitSemiBold14
                            .textColor(appCtrl.appTheme.txt)),
                    const VSpace(Sizes.s20),
                    const SliderLayout(),
                    const VSpace(Sizes.s20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: emailGeneratorCtrl.mailLengthLists
                            .asMap()
                            .entries
                            .map((e) => Text(e.value.toString().tr,
                                style: AppCss.outfitSemiBold14.textColor(
                                    emailGeneratorCtrl.value >= e.key
                                        ? appCtrl.appTheme.primary
                                        : appCtrl.appTheme.lightText)))
                            .toList())
                  ]))
                  .paddingSymmetric(
                      horizontal: Insets.i15, vertical: Insets.i20)
                  .authBoxExtension()
            ]),
            const VSpace(Sizes.s30),
            ButtonCommon(
                title: appFonts.myFitnessMail,
                onTap: () => emailGeneratorCtrl.onGenerateMail())
          ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
