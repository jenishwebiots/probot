

import '../../../../config.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        toolbarHeight: Sizes.s80,
        leadingWidth: Sizes.s80,
        automaticallyImplyLeading: false,
        leading:const CommonMenuIcon(),
        pinned: true,
        expandedHeight: Sizes.s330,
        title:
        Image.asset(eImageAssets.logo1, width: Sizes.s106),
        centerTitle: true,
        actions: [
          SvgPicture.asset(eSvgAssets.bell)
              .paddingSymmetric(horizontal: Insets.i20)
        ],
        flexibleSpace: Container(
            padding: const EdgeInsets.only(top: Insets.i100),
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    focalRadius: 1,
                    radius: 1,
                    center: const Alignment(-0.1, 0.1),
                    colors: [
                      appCtrl.appTheme.primary,
                      appCtrl.appTheme.radialGradient
                    ])),
            child: Image.asset(
              eImageAssets.homeAppBar,
            ).paddingSymmetric(
                vertical: Insets.i30, horizontal: Insets.i35)));
  }
}
