import '../../../config.dart';

class ValentineDayScreen extends StatelessWidget {
  final valCtrl = Get.put(ValentineDayController());

  ValentineDayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ValentineDayController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          resizeToAvoidBottomInset: false,
          appBar: AppAppBarCommon(
              title: appFonts.valentineDayMessage,
              leadingOnTap: () => Get.back()),
          body: SingleChildScrollView(
              child: valCtrl.isValentineGenerate == true
                  ? Column(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textCommon.outfitSemiBoldPrimary16(
                                text: appFonts.wonderfulMessage),
                            const VSpace(Sizes.s15),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputLayout(
                                      hintText: "",
                                      title: appFonts.valentineDay,
                                      color: appCtrl.appTheme.white,
                                      isMax: false,
                                      controller: valCtrl.valWishGenController),
                                  const VSpace(Sizes.s20),
                                  ButtonCommon(
                                      title: appFonts.endLovelyMessage,
                                      onTap: () => valCtrl.endValentine())
                                ])
                          ])
                    ]).paddingSymmetric(
                      vertical: Insets.i30, horizontal: Insets.i20)
                  : const ValentineDayLayout()));
    });
  }
}
