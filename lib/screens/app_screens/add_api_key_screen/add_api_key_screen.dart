import '../../../config.dart';

class AddApiKeyScreen extends StatelessWidget {
  final apiCtrl = Get.put(AddApiKeyController());
 final GlobalKey<ScaffoldState> apiScaffoldKey = GlobalKey<ScaffoldState>();
 final GlobalKey<FormState> addApiGlobalKey = GlobalKey<FormState>();
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
            key: apiScaffoldKey,
              backgroundColor: appCtrl.appTheme.bg1,
              appBar: AppAppBarCommon(
                  title: appFonts.addApiKey, leadingOnTap: () => Get.back()),
              body: SingleChildScrollView(
                child: Form(
                  key: addApiGlobalKey,
                  child: Column(children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(appFonts.addKey.tr,
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
                          ApiNotesLayout(title: appFonts.yourMobileDevices.tr),
                          const VSpace(Sizes.s25),
                          ApiNotesLayout(title: appFonts.youCanKeep.tr),
                          const VSpace(Sizes.s25),
                          ApiNotesLayout(title: appFonts.balanceNote.tr)
                        ],
                      ).paddingSymmetric(horizontal: Insets.i15)
                    ]).paddingSymmetric(vertical: Insets.i20).authBoxExtension(),
                    const VSpace(Sizes.s30),
                    ButtonCommon(
                        title: appFonts.save,
                        onTap: () {
                          if(addApiGlobalKey.currentState!.validate()){
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
