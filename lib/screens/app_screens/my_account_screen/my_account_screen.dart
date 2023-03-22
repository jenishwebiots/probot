import 'package:probot/config.dart';


class MyAccountScreen extends StatelessWidget {
  final myAccountCtrl = Get.put(MyAccountController());

  MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAccountController>(builder: (_) {
      return Scaffold(
          appBar: AppAppBarCommon(
              title: appFonts.myAccount, leadingOnTap: () => Get.back()),
          body: Column(children: [
            const VSpace(Sizes.s10),
            Stack(alignment: Alignment.bottomRight, children: [
              Text(
                      (myAccountCtrl.userName != null ||
                              myAccountCtrl.name != null ||
                              myAccountCtrl.firebaseUser != null)
                          ? myAccountCtrl.userName != null
                              ? myAccountCtrl.userName![0]
                              : myAccountCtrl.name != null
                                  ? myAccountCtrl.name![0]
                                  : myAccountCtrl.firebaseUser![0]
                          : "",
                      style: AppCss.outfitExtraBold40
                          .textColor(appCtrl.appTheme.sameWhite))
                  .paddingAll(Insets.i40)
                  .decorated(
                      shape: BoxShape.circle, color: appCtrl.appTheme.primary),
              SvgPicture.asset(eSvgAssets.camera, fit: BoxFit.scaleDown)
                  .paddingAll(Insets.i8)
                  .decorated(
                      shape: BoxShape.circle,
                      color: appCtrl.appTheme.sameWhite,
                      border: Border.all(
                          width: 2,
                          color: appCtrl.appTheme.primary.withOpacity(0.1)))
                  .paddingOnly(bottom: Insets.i8)
            ]),
            const VSpace(Sizes.s15),
            const AllTextForm()
                .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i25)
                .authBoxExtension()
          ])
              .paddingSymmetric(horizontal: Insets.i20)
              .alignment(Alignment.center));
    });
  }
}
