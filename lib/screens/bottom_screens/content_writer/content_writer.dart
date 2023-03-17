
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
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
        body: SingleChildScrollView(
          child: Column(
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
                  ButtonCommon(title: appFonts.generateContent).marginSymmetric(vertical: Insets.i40)
                ],
              ).marginAll(Insets.i25),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(appFonts.description.tr,style: AppCss.outfitSemiBold18.textColor(appCtrl.appTheme.primary)),
                      Row(
                        children: [
                          SvgPicture.asset(eSvgAssets.share).descriptionOptionBg(),
                          const HSpace(Sizes.s12),
                          SvgPicture.asset(eSvgAssets.trash).descriptionOptionBg().inkWell(onTap: (){
                            String parsedstring3 = Bidi.stripHtmlIfNeeded(contentCtrl.htmlData);
                            print(parsedstring3);
                          }),
                          const HSpace(Sizes.s12),
                          SvgPicture.asset(eSvgAssets.copy).descriptionOptionBg().inkWell(onTap: ()async{
                            String parsedstring3 = Bidi.stripHtmlIfNeeded(contentCtrl.htmlData);
                            print(parsedstring3);
                            Clipboard.setData(ClipboardData(text:parsedstring3)).then((_){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email address copied to clipboard")));
                            });
                          }),
                          const HSpace(Sizes.s12),
                          SvgPicture.asset(eSvgAssets.edit).descriptionOptionBg(),
                        ],
                      )
                    ],
                  ),
                  const   VSpace(Sizes.s15),
                  RawScrollbar(
                    controller: contentCtrl.scrollController,
                    trackColor: appCtrl.appTheme.greyLight,
                    thumbColor: appCtrl.appTheme.primary,
                    radius:const Radius.circular(AppRadius.r4),
                    thickness: 3,
                    child:ListView(

                      children: [
                        HtmlWidget(
                          contentCtrl.htmlData,

                        ).paddingAll(Insets.i20).decorated(color: appCtrl.appTheme.bg1,borderRadius: BorderRadius.circular(AppRadius.r6)),
                      ]
                    ).height(Sizes.s350),
                  )
                ],
              ).paddingAll(Insets.i20).decorated(color: appCtrl.appTheme.white,borderRadius: BorderRadius.circular(AppRadius.r8))
            ],
          ),
        ),
      );
    });
  }
}
