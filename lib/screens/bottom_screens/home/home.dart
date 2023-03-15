import 'package:probot/config.dart';

class Home extends StatelessWidget {
  final homeCtrl = Get.put(HomeController());

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
        backgroundColor: appCtrl.appTheme.bg1,
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              toolbarHeight: Sizes.s80,
              leadingWidth: Sizes.s80,
              automaticallyImplyLeading: false,
              leading: SvgPicture.asset(eSvgAssets.menu)
                  .paddingSymmetric(horizontal: Insets.i20),
              pinned: true,
              expandedHeight: Sizes.s340,
              title: Image.asset(eImageAssets.logo1, width: Sizes.s106),
              centerTitle: true,
              actions: [
                SvgPicture.asset(
                  eSvgAssets.bell,
                ).inkWell(onTap: ()=> Get.toNamed(routeName.notificationScreen)).paddingSymmetric(horizontal: Insets.i20)
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
                    vertical: Insets.i30, horizontal: Insets.i35),
              ),
            )
          ],
        ));
    });
  }
}
