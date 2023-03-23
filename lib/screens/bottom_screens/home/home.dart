
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:probot/config.dart';


class Home extends StatelessWidget {
  final homeCtrl = Get.put(HomeController());

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return CommonStream(child: Scaffold(
          key: homeCtrl.scaffoldKey,
          drawer: const CommonDrawer(),
          backgroundColor: appCtrl.appTheme.bg1,
          body: Stack(alignment: Alignment.bottomCenter, children: [
            NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) =>
                [const HomeSliverAppBar()],
                body: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const DottedLines(),

                      Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const VSpace(Sizes.s20),
                            ...homeCtrl.homeOptionList.asMap().entries.map((e) {
                              return ((appCtrl.firebaseConfigModel!.isChatShow! && e.key == 0) ||
                                  (appCtrl.firebaseConfigModel!.isImageGeneratorShow! &&
                                      e.key == 1) ||
                                  ((appCtrl.firebaseConfigModel!.isTextCompletionShow! &&
                                      e.key == 2)))
                                  ? OptionCard(homeOptionModel: e.value).inkWell(
                                  onTap: () => homeCtrl.onOptionTap(e.value))
                                  : Container();
                            }).toList(),
                          ]).marginSymmetric(horizontal: Sizes.s20)
                    ]))),
            if (homeCtrl.bannerAd != null)
              AdWidget(ad: homeCtrl.bannerAd!)
                  .height(Sizes.s50).paddingOnly(bottom: Insets.i10)
                  .width(MediaQuery.of(context).size.width)
          ])),);
    });
  }
}
