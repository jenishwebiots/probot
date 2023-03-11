import '../../../../config.dart';

class PageViewCommon extends StatelessWidget {
  final String? image, title, subtitle;
  final GestureTapCallback? onTap;

  const PageViewCommon(
      {Key? key, this.title, this.image, this.onTap, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (onBoardingCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          onBoardingCtrl.selectIndex != 2
              ? Text(appFonts.skip,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.lightText))
                  .inkWell(onTap: () => onBoardingCtrl.pageCtrl.jumpToPage(2))
                  .paddingOnly(
                      top: Insets.i50, bottom: Insets.i12, right: Insets.i12)
              : const Text("").paddingOnly(
                  top: Insets.i50, bottom: Insets.i12, right: Insets.i12),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: Image.asset(image!, fit: BoxFit.cover))
        ]),
        const VSpace(Sizes.s40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
              onBoardingCtrl.onBoardingLists.length,
                  (index) => InkWell(
                    onTap: () {
                      onBoardingCtrl.pageCtrl.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: const SizedBox(height: Sizes.s5, width: Sizes.s22)
                        .decorated(
                        color: onBoardingCtrl.selectIndex >= index ? appCtrl.appTheme.primary : appCtrl.appTheme.primary.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadius.r10))).paddingSymmetric(horizontal: Insets.i3)
                  ))
        ),

        const VSpace(Sizes.s10),
        Stack(alignment: Alignment.bottomCenter, children: [
          SizedBox(
              height: 215,
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(alignment: Alignment.topCenter, children: [
                      Image.asset(eImageAssets.container,
                          fit: BoxFit.fill,
                          height: 200,
                          width: double.infinity),
                      Column(
                        children: [
                          Text(title!,
                              style: AppCss.outfitMedium22
                                  .textColor(appCtrl.appTheme.txt)),
                          const VSpace(Sizes.s5),
                          Divider(
                              height: 2,
                              thickness: 2,
                              color: appCtrl.appTheme.primary,
                              endIndent: 180,
                              indent: 180),
                          const VSpace(Sizes.s10),
                          SizedBox(
                              width: 292,
                              child: Text(subtitle!,
                                  textAlign: TextAlign.center,
                                  style: AppCss.outfitMedium16
                                      .textColor(appCtrl.appTheme.lightText)
                                      .textHeight(1.5)))
                        ]
                      ).paddingOnly(top: Insets.i30)
                    ])
                  ])),
          SizedBox(
                  height: Sizes.s52,
                  width: Sizes.s52,
                  child: SvgPicture.asset(eSvgAssets.rightArrow,
                      fit: BoxFit.scaleDown))
              .inkWell(onTap: onTap)
              .decorated(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    appCtrl.appTheme.primary.withOpacity(0.5),
                    appCtrl.appTheme.primary
                  ], center: const Alignment(-0.9, -0.4)))
        ])
      ]);
    });
  }
}
