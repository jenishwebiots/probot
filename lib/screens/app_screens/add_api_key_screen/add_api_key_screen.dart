import '../../../config.dart';

class AddApiKeyScreen extends StatelessWidget {
  final apiCtrl = Get.put(AddApiKeyController());

  AddApiKeyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddApiKeyController>(builder: (_) {
      return WillPopScope(
        onWillPop: () async{
           Get.toNamed(routeName.dashboard);
           return false;
        },
        child: DirectionalityRtl(
          child: Scaffold(
              backgroundColor: appCtrl.appTheme.bg1,
              appBar: AppAppBarCommon(
                  title: appFonts.addApiKey, leadingOnTap: () => Get.toNamed(routeName.dashboard)),
              body: SingleChildScrollView(
                child: Form(
                  key: apiCtrl.addApiGlobalKey,
                  child: Column(children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(appFonts.addKey,
                            style: AppCss.outfitMedium18
                                .textColor(appCtrl.appTheme.primary)),
                        const VSpace(Sizes.s15),
                        textCommon.outfitSemiBoldTxt14(text: appFonts.addKey),
                        const VSpace(Sizes.s10),
                        TextFieldCommon(
                            hintText: appFonts.enterYourApi,
                            controller: apiCtrl.apiController)
                      ]).paddingSymmetric(horizontal: Insets.i15),
                      DottedLines(color: appCtrl.appTheme.txt.withOpacity(0.10))
                          .paddingSymmetric(vertical: Insets.i15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(appFonts.note,
                              style: AppCss.outfitMedium16
                                  .textColor(appCtrl.appTheme.primary)),
                          const VSpace(Sizes.s15),
                          ApiNotesLayout(title: appFonts.yourMobileDevices),
                          const VSpace(Sizes.s25),
                          ApiNotesLayout(title: appFonts.youCanKeep)
                        ],
                      ).paddingSymmetric(horizontal: Insets.i15)
                    ]).paddingSymmetric(vertical: Insets.i20).authBoxExtension(),
                    const VSpace(Sizes.s30),
                    ButtonCommon(
                        title: appFonts.save,
                        onTap: () {
                          if(apiCtrl.addApiGlobalKey.currentState!.validate()){
                            apiCtrl.addApiKeyInLocal();
                          }
                        })
                  ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i30),
                ),
              )),
        ),
      );
    });
  }
}
