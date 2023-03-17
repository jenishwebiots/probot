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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appFonts.businessIdea.tr,
                    style:
                        AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt)),
                const VSpace(Sizes.s8),
                DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      colorScheme: ColorScheme.light(background: appCtrl.appTheme.sameWhite),
                        child: DropdownButton(
                            value: contentCtrl.selectedValue,

                            borderRadius: const BorderRadius.all(
                                Radius.circular(AppRadius.r8)),
                            style: AppCss.outfitMedium14
                                .textColor(appCtrl.appTheme.lightText),
                            icon: SvgPicture.asset(eSvgAssets.fingerLock),
                            isDense: true,
                            isExpanded: true,
                            hint: Text(appFonts.businessIdea.tr),
                            items: contentCtrl.contentOptionList
                                .asMap()
                                .entries
                                .map((e) => DropdownMenuItem(

                                value: e.value, child: Text(e.value.toString().tr)))
                                .toList(),
                            onChanged: (val){})
                    )),
                const VSpace(Sizes.s15),
                Text(appFonts.topic.tr,
                    style:
                    AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt)),
                const VSpace(Sizes.s8),
                TextFieldCommon(

                    hintText: appFonts.exUiUx,
                    fillColor: appCtrl.appTheme.surface,).authBoxExtension(),
                const VSpace(Sizes.s10),
              ],
            ).marginAll(Insets.i25)
          ],
        ),
      );
    });
  }
}
