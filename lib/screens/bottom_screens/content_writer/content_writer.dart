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
          leadingWidth: Sizes.s70,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContentCommonWidget().commonText(appFonts.businessIdea),
                const VSpace(Sizes.s8),
                const BusinessIdeaDropDown().authBoxExtension(),
                const VSpace(Sizes.s15),
                ContentCommonWidget().commonText(appFonts.topic),
                const VSpace(Sizes.s8),
                TextFieldCommon(
                  hintText: appFonts.exUiUx,
                  fillColor: appCtrl.appTheme.surface,
                ).authBoxExtension(),
                const VSpace(Sizes.s40),
                ButtonCommon(title: appFonts.generateContent)
              ],
            ).marginAll(Insets.i25)
          ],
        ),
      );
    });
  }
}
