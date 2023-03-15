import 'package:probot/config.dart';

class Home extends StatelessWidget {
  final homeCtrl = Get.put(HomeController());

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
          key: homeCtrl.scaffoldKey,
          drawer:const CommonDrawer(),
          backgroundColor: appCtrl.appTheme.bg1,
          body: NestedScrollView(
              headerSliverBuilder: (BuildContext context,
                  bool innerBoxIsScrolled) =>
              [
                const HomeSliverAppBar()
              ],
              body: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const DottedLines(),
                    const VSpace(Sizes.s20),
                    Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                          appFonts.chooseOption.tr,
                          style: AppCss.outfitRegular16
                              .textColor(appCtrl.appTheme.lightText)
                              .textHeight(1.3)
                              .letterSpace(.3)),
                      const VSpace(Sizes.s20),
                      ...homeCtrl.homeOptionList.asMap().entries.map((e) {
                        return OptionCard(homeOptionModel: e.value)
                            .inkWell(onTap: () => homeCtrl.onOptionTap(e.key));
                      }).toList()
                    ]).marginSymmetric(horizontal: Sizes.s20)
                  ]))));
    });
  }
}