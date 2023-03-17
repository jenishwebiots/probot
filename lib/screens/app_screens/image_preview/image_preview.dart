

import '../../../config.dart';

class ImagePreview extends StatelessWidget {
  final imagePreviewCtrl = Get.put(ImagePreviewController());
   ImagePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePreviewController>(
      builder: (_) {
        return Scaffold(
            body: Stack(children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(imagePreviewCtrl.image, fit: BoxFit.cover)),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              SvgPicture.asset(eSvgAssets.leftArrow,
                  colorFilter: ColorFilter.mode(
                      appCtrl.appTheme.sameWhite, BlendMode.srcIn)).inkWell(onTap: ()=> Get.back()),
              const HSpace(Sizes.s18),
              Text(appFonts.imagePreview,
                  style:
                      AppCss.outfitSemiBold22.textColor(appCtrl.appTheme.sameWhite))
            ]),
            Row(children: [
              Expanded(child: ButtonCommon(title: appFonts.share)),
              const HSpace(Sizes.s15),
              Expanded(child: ButtonCommon(title: appFonts.download))
            ])
          ]).padding(horizontal: Insets.i20, top: Insets.i60, bottom: Insets.i40)
        ]));
      }
    );
  }
}
