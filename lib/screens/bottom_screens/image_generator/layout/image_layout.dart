import '../../../../config.dart';

class ImageLayout extends StatelessWidget {
  const ImageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      SizedBox(
          width: Sizes.s160,
          height: Sizes.s155,
          child: Image.asset(eImageAssets.ig1, fit: BoxFit.fill)),
      SizedBox(
              child:
                  SvgPicture.asset(eSvgAssets.download).paddingAll(Insets.i8))
          .decorated(
              color: appCtrl.appTheme.txt.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppRadius.r8),
                  topRight: Radius.circular(AppRadius.r8)))
    ]);
  }
}
