import 'dart:ui';
import '../../../config.dart';
import 'layout/filter_layout.dart';
import 'layout/loader_layout.dart';
import 'layout/page_and_grid_view.dart';
import 'layout/top_layout.dart';

class ImageGenerator extends StatelessWidget {
  final imageGeneratorCtrl = Get.put(ImageGeneratorController());

  ImageGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageGeneratorController>(builder: (_) {
      return Stack(children: [
        Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                backgroundColor: appCtrl.appTheme.primary,
                elevation: 0,
                toolbarHeight: 70,
                automaticallyImplyLeading: false,
                title: Text(appFonts.imageGenerator,
                    style: AppCss.outfitSemiBold22
                        .textColor(appCtrl.appTheme.sameWhite))),
            body: Stack(alignment: Alignment.center, children: [
              Stack(alignment: Alignment.bottomCenter, children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: const [
                          TopLayout(),
                          VSpace(Sizes.s20),
                          PageAndGridView()
                        ])
                      ]).paddingSymmetric(
                      horizontal: Insets.i20, vertical: Insets.i20),
                )).height(MediaQuery.of(context).size.height),
                ButtonCommon(
                  title: appFonts.generateImage,
                  onTap: () => imageGeneratorCtrl.onTabMethod()
                ).paddingOnly(
                    bottom: Insets.i15, right: Insets.i20, left: Insets.i20)
              ]),
              if (imageGeneratorCtrl.isLoader) const LoaderLayout()
            ])),
        if (imageGeneratorCtrl.isFilter)
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(color: appCtrl.appTheme.sameWhite.withOpacity(0.6))),
        if (imageGeneratorCtrl.isFilter) const FilterLayout()
      ]);
    });
  }
}
