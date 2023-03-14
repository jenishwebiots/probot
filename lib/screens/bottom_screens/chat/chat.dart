import 'package:probot/config.dart';

class Chat extends StatelessWidget {
  final chatCtrl = Get.put(ChatController());

  Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (_) {
      return Scaffold(
        key: chatCtrl.scaffoldKey,
        drawer:const CommonDrawer(),
        appBar: AppBar(
          leadingWidth: Sizes.s80,
          leading: const CommonMenuIcon().inkWell(onTap: ()=> chatCtrl.scaffoldKey.currentState!.openDrawer()),
          automaticallyImplyLeading: false,
          backgroundColor: appCtrl.appTheme.primary,
          title: Text(appFonts.chatWithProBot.tr,
              style:
                  AppCss.outfitExtraBold22.textColor(appCtrl.appTheme.white)),
        ),
        backgroundColor: appCtrl.appTheme.bg1,
        body: Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(appFonts.listCharacter.tr,
                                    style: AppCss.outfitSemiBold22
                                        .textColor(appCtrl.appTheme.txt)),
                                const VSpace(Sizes.s10),
                                Text(appFonts.tapCharacter.tr,
                                    style: AppCss.outfitMedium16
                                        .textColor(appCtrl.appTheme.lightText)),
                                const DottedLines()
                                    .paddingOnly(top: Insets.i20),
                                const VSpace(Sizes.s20),
                                GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: chatCtrl.chatOptionList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 15,
                                          mainAxisExtent: 110,
                                          mainAxisSpacing: 10,
                                          crossAxisCount: 3),
                                  itemBuilder: (context, index) {
                                    return CharacterLayout(
                                        isSelectedShow: false,
                                        index: index,
                                        data: chatCtrl.chatOptionList[index]).inkWell(onTap: ()=> Get.toNamed(routeName.chatLayout,arguments:{"data":chatCtrl.chatOptionList[index],"index":index} ));
                                  },
                                )
                              ]).paddingSymmetric(
                              horizontal: Insets.i20, vertical: Insets.i25))
                      .authBoxExtension(),
                ]).paddingSymmetric(
                horizontal: Insets.i20, vertical: Insets.i15)),
      );
    });
  }
}
