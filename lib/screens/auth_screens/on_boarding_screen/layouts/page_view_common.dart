import 'dart:developer';

import '../../../../config.dart';

class PageViewCommon extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;
  final String? title,description;

  const PageViewCommon({Key? key, this.onTap, this.data,this.title,this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (onBoardingCtrl) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(alignment: Alignment.topRight, children: [
              SizedBox(
                      height: MediaQuery.of(context).size.height < 534
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.58,
                      width: MediaQuery.of(context).size.height < 534
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.58,
                      child: Image.network(data, fit: BoxFit.cover))
                  .paddingOnly(top: Insets.i45),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                    width: Sizes.s106,
                    child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            child: DropdownButton(
                                    value: onBoardingCtrl.langValue,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(AppRadius.r8)),
                                    style: AppCss.outfitSemiBold16
                                        .textColor(appCtrl.appTheme.txt),
                                    icon: SvgPicture.asset(eSvgAssets.dropDown,
                                        colorFilter: ColorFilter.mode(
                                            appCtrl.appTheme.txt, BlendMode.srcIn)),
                                    isDense: true,
                                    isExpanded: true,
                                    hint: Text(appFonts.english.toString().tr),
                                    items: onBoardingCtrl.selectLanguageLists
                                        .asMap()
                                        .entries
                                        .map((e) {
                                      return DropdownMenuItem(
                                          value: e.value.title,
                                          child: Row(children: [
                                            Image.asset(e.value.image!,
                                                height: Sizes.s30),
                                            const HSpace(Sizes.s6),
                                            Text(e.value.title!.toString().tr,
                                                    overflow:
                                                        TextOverflow.ellipsis)
                                                .width(Sizes.s55)
                                          ]),
                                          onTap: () => onBoardingCtrl
                                              .onLanguageSelectTap(e.value));
                                    }).toList(),
                                    onChanged: (val) async {
                                      onBoardingCtrl.langValue = val.toString();
                                      onBoardingCtrl.update();
                                    })
                                .paddingOnly(
                                    top: Insets.i50, bottom: Insets.i10)))),
                if (onBoardingCtrl.selectIndex != 2)
                  Text(appFonts.skip.tr,
                          style: AppCss.outfitMedium16
                              .textColor(appCtrl.appTheme.lightText))
                      .inkWell(
                          onTap: () => onBoardingCtrl.pageCtrl.jumpToPage(2))
                      .paddingOnly(top: Insets.i50, bottom: Insets.i10)
              ]).paddingSymmetric(horizontal: Insets.i20)
            ]),
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
                        child: const SizedBox(
                                height: Sizes.s5, width: Sizes.s22)
                            .decorated(
                                color: onBoardingCtrl.selectIndex >= index
                                    ? appCtrl.appTheme.primary
                                    : appCtrl.appTheme.primary.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(AppRadius.r10)))
                            .paddingSymmetric(horizontal: Insets.i3)))),
            const VSpace(Sizes.s10),
            Stack(alignment: Alignment.bottomCenter, children: [
              SizedBox(
                  height: Sizes.s215,
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(alignment: Alignment.topCenter, children: [
                          Image.asset(eImageAssets.container,
                              color: appCtrl.isTheme
                                  ? appCtrl.appTheme.boxBg
                                  : appCtrl.appTheme.white,
                              fit: BoxFit.fill,
                              height: 200,
                              width: double.infinity),
                          Column(children: [
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
                                width: Sizes.s292,
                                child: Text(description!,
                                    textAlign: TextAlign.center,
                                    style: AppCss.outfitMedium16
                                        .textColor(appCtrl.appTheme.lightText)
                                        .textHeight(1.5)))
                          ]).paddingOnly(top: Insets.i30)
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
                        appCtrl.appTheme.secondary,
                        appCtrl.appTheme.primary
                      ], center: const Alignment(-0.9, -0.4)))
            ]).marginOnly(bottom: Insets.i3)
          ]);
    });
  }
}
