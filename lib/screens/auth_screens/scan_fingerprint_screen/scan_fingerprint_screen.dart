import '../../../config.dart';

class ScanFingerprintScreen extends StatelessWidget {
  const ScanFingerprintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCtrl.appTheme.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: appCtrl.appTheme.primary,
        title: Row(
          children: [
            const HSpace(Sizes.s10),
            SvgPicture.asset(eSvgAssets.leftArrow,
                fit: BoxFit.scaleDown,
                colorFilter:
                    ColorFilter.mode(appCtrl.appTheme.white, BlendMode.srcIn)),
            const HSpace(Sizes.s17),
            Text(appFonts.addFingerprint, style: AppCss.outfitSemiBold22),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                    width: 283,
                    child: Text(appFonts.placeYourFinger,
                        textAlign: TextAlign.center,
                        style: AppCss.outfitMedium22
                            .textColor(appCtrl.appTheme.txt)
                            .textHeight(1.3))),
                const VSpace(Sizes.s8),
                Text(appFonts.pressTheSensor,style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText)),
              ],
            ),
            Image.asset(eGifAssets.fingerprint,height: 248,width: 248),
            Image.asset(eImageAssets.fingerprint,height: 100,width: 100),

          ],
        ).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i40),
      ),
    );
  }
}
