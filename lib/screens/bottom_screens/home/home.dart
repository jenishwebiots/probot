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
          body: SingleChildScrollView(
            child: Column(
              children: [
                const DottedLines(),
                const VSpace(Sizes.s20),
                Column(
                  children: [
                    Text(
                        "Choose one of the following to enjoy the greatest experience.",
                        style: AppCss.outfitRegular16
                            .textColor(appCtrl.appTheme.lightText)
                            .textHeight(1.3)
                            .letterSpace(.3)),
                    const VSpace(Sizes.s20),
                    ...homeCtrl.homeOptionList.asMap().entries.map((e) {
                      return Row(
                        children: [
                          SvgPicture.asset(e.value.image.toString(),height: Sizes.s28,
                                  colorFilter: ColorFilter.mode(
                                      appCtrl.appTheme.white, BlendMode.srcIn))
                              .paddingAll(Insets.i13)
                              .decorated(
                                  color: appCtrl.appTheme.primary,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r8)),
                          const HSpace(Sizes.s11),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.value.title.toString().tr,style: AppCss.outfitBold18.textColor(appCtrl.appTheme.txt),)
                            ],
                          )
                        ],
                      ).paddingSymmetric(horizontal:Insets.i15,vertical: Insets.i18).decorated(
                          color: appCtrl.appTheme.white,
                          borderRadius: BorderRadius.circular(AppRadius.r10),
                          boxShadow: [const BoxShadow(
                            color: Color.fromRGBO(53, 193, 255, 0.06),
                            offset: Offset(0,2),
                            blurRadius: 20
                          )],
                          border: Border.all(
                              color: appCtrl.appTheme.borderColor,width: 1.5)).marginOnly(bottom: Insets.i15);
                    }).toList()
                  ],
                ).marginSymmetric(horizontal: Sizes.s20)
              ],
            ),
          ),
        ),
      );
    });
  }
}
