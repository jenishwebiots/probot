import '../../../../config.dart';

class QuickAdvisorLayout extends StatelessWidget {
  final dynamic data;

  const QuickAdvisorLayout({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Stack(alignment: Alignment.topCenter, children: [
        SizedBox(
            height: Sizes.s110,
            width: Sizes.s100,
            child: Image.asset(eImageAssets.quickAdvisorContainer,alignment: Alignment.bottomCenter)),
        SizedBox(
            child: SvgPicture.asset(data["icon"])
                .paddingAll(Insets.i12)
                .decorated(
                    color: appCtrl.appTheme.primary, shape: BoxShape.circle))
      ]),
      SizedBox(
        width: Sizes.s80,
        child: Text(data["title"].toString().tr,textAlign: TextAlign.center,
                style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt))
            .paddingOnly(bottom: Insets.i10),
      )
    ]).inkWell(onTap: () {
      if (data["title"] == appFonts.translateAnything) {
        Get.toNamed(routeName.translateScreen);
      } else if (data["title"] == appFonts.codeGenerator) {
        Get.toNamed(routeName.codeGeneratorScreen);
      } else if (data["title"] == appFonts.emailGenerator) {
        Get.toNamed(routeName.emailWriterScreen);
      } else if (data["title"] == appFonts.socialMedia) {
        Get.toNamed(routeName.socialMediaScreen);
      } else if (data["title"] == appFonts.passwordGenerator) {
        Get.toNamed(routeName.passwordGeneratorScreen);
      }

    });
  }
}
