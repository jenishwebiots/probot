import 'package:probot/config.dart';

class ContentWriter extends StatelessWidget {
  final contentCtrl = Get.put(ContentWriterController());

  ContentWriter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentWriterController>(builder: (_) {
      return Scaffold(
        backgroundColor: appCtrl.appTheme.bg1,
        key: contentCtrl.scaffoldKey,
        drawer: const CommonDrawer(),
        appBar: AppBar(
          leadingWidth: Sizes.s80,
          leading: const CommonMenuIcon().inkWell(
              onTap: () => contentCtrl.scaffoldKey.currentState!.openDrawer()),
          automaticallyImplyLeading: false,
          backgroundColor: appCtrl.appTheme.primary,
          title: Text(appFonts.option3.tr,
              style: AppCss.outfitExtraBold22
                  .textColor(appCtrl.appTheme.sameWhite)),
        ),
        body: Column(
          children: [
            Column(
              children: [
                Text(appFonts.businessIdea.tr,
                    style:
                        AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt)),
                const VSpace(Sizes.s8)
              ],
            ).marginAll(Insets.i25)
          ],
        ),
      );
    });
  }
}
