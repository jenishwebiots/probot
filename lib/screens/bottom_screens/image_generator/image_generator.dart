import '../../../config.dart';
import 'layout/drop_down_layout.dart';

class ImageGenerator extends StatelessWidget {
  final imageGeneratorCtrl = Get.put(ImageGeneratorController());

  ImageGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageGeneratorController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: appCtrl.appTheme.primary,
            elevation: 0,
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            title: Text(appFonts.imageGenerator,
                style: AppCss.outfitSemiBold22
                    .textColor(appCtrl.appTheme.sameWhite))),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                TextFieldCommon(
                    hintText: appFonts.search,
                    fillColor: appCtrl.appTheme.surface,
                    prefixIcon: SvgPicture.asset(eSvgAssets.search,
                        fit: BoxFit.scaleDown),
                    suffixIcon: SizedBox(
                        height: 10,
                        width: 10,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const VerticalDivider(
                                  width: 1,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10),
                              SvgPicture.asset(eSvgAssets.filter,
                                      fit: BoxFit.scaleDown)
                                  .paddingSymmetric(horizontal: Insets.i10)
                            ]))).authBoxExtension(),
                const VSpace(Sizes.s10),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropDownLayout(
                          value: imageGeneratorCtrl.imageValue,
                          title: appFonts.imageSize,
                          hintText: appFonts.selectSize,
                          dropDownList: imageGeneratorCtrl.imageSizeLists
                              .asMap()
                              .entries
                              .map((e) => DropdownMenuItem(
                                  value: e.value, child: Text(e.value)))
                              .toList(),
                          onChanged: (val) {
                            imageGeneratorCtrl.imageValue = val.toString();
                            imageGeneratorCtrl.update();
                          }),
                      const HSpace(Sizes.s15),
                      DropDownLayout(
                        value: imageGeneratorCtrl.viewValue,
                        title: appFonts.viewType,
                        hintText: appFonts.selectType,
                        dropDownList: imageGeneratorCtrl.viewTypeLists
                            .asMap()
                            .entries
                            .map((e) => DropdownMenuItem(
                                value: e.value, child: Text(e.value)))
                            .toList(),
                        onChanged: (val) {
                          imageGeneratorCtrl.viewValue = val.toString();
                          imageGeneratorCtrl.update();
                        }
                      )
                    ]
                  ).paddingAll(Insets.i15)
                ).authBoxExtension(),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    SizedBox(
                      width: Sizes.s160,
                        height: Sizes.s155,
                        child: Image.asset(eImageAssets.ig1,fit: BoxFit.fill)),
                    SizedBox(
                         child: SvgPicture.asset(eSvgAssets.download).paddingAll(Insets.i8)
                    ).decorated(color: appCtrl.appTheme.txt.withOpacity(0.3),borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(AppRadius.r8),topRight: Radius.circular(AppRadius.r8)))
                  ],
                )
              ]),
              ButtonCommon(title: appFonts.generateImage)
            ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i20),
      );
    });
  }
}
