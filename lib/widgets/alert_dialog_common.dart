import 'package:flutter/cupertino.dart';

import '../../config.dart';

class AlertDialogCommon extends StatelessWidget {
  final String? image, title, subtext, bText1;
  final GestureTapCallback? b1OnTap;

  const AlertDialogCommon(
      {Key? key,
        this.title,
        this.b1OnTap,
        this.bText1,
        this.image,
        this.subtext
       })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.r14))),
        backgroundColor: appCtrl.appTheme.white,
        content: Stack(alignment: Alignment.topRight, children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            // Gif
            Image.asset(image!, height: Sizes.s230, width: Sizes.s230),
            // Title
            Text(title!.tr,
                style:
                AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
            const VSpace(Sizes.s18),
            // Sub text
            Text(subtext!.tr,
                textAlign: TextAlign.center,
                style: AppCss.outfitMedium14
                    .textColor(appCtrl.appTheme.lightText)
                    .textHeight(1.5))
                .paddingSymmetric(horizontal: Insets.i10),
            const VSpace(Sizes.s25),
            ButtonCommon(onTap: b1OnTap, title: bText1!),

          ]).paddingAll(Insets.i20),
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(CupertinoIcons.multiply,
                  size: Sizes.s20, color: appCtrl.appTheme.lightText))
        ]));
  }
}
