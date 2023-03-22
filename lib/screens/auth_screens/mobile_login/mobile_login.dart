import '../../../config.dart';

class MobileLogin extends StatelessWidget {
  final mobileCtrl = Get.put(MobileLoginController());

  MobileLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MobileLoginController>(builder: (_) {
      return Scaffold(
          appBar: const AppBarCommon(isArrow: false),
          body: Stack(alignment: Alignment.center, children: [
            Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Form(
                      key: mobileCtrl.mobileGlobalKey,
                      child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(appFonts.phoneNumberVerification.tr,
                                        style: AppCss.outfitSemiBold22
                                            .textColor(appCtrl.appTheme.txt)),
                                    const VSpace(Sizes.s10),
                                    Text(appFonts.enterNumber.tr,
                                        style: AppCss.outfitMedium16.textColor(
                                            appCtrl.appTheme.lightText)),
                                    const DottedLines().paddingOnly(
                                        top: Insets.i20, bottom: Insets.i15),
                                    Text(appFonts.phone.tr,
                                        style: AppCss.outfitMedium16
                                            .textColor(appCtrl.appTheme.txt)),
                                    const VSpace(Sizes.s10),
                                    TextFieldCommon(
                                        maxLength: 10,
                                        validator: (phone) =>
                                            Validation().phoneValidation(phone),
                                        controller: mobileCtrl.mobileController,
                                        hintText: appFonts.enterPhoneNo.tr),
                                    const VSpace(Sizes.s40),
                                    ButtonCommon(
                                      title: appFonts.getOTP,
                                    )
                                  ]).paddingSymmetric(
                                  horizontal: Insets.i20, vertical: Insets.i25))
                          .authBoxExtension()),
                  Text(appFonts.simplyUseThis.tr,
                      textAlign: TextAlign.center,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.lightText)
                          .textHeight(1.3))
                ])
                .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i15),
            if (mobileCtrl.isLoading == true)
              const Center(child: CircularProgressIndicator())
          ]));
    });
  }
}
