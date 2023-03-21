import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';

import '../../../../config.dart';

class ContentDescription extends StatelessWidget {
  const ContentDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentWriterController>(builder: (contentCtrl) {
      log("LENGTH : ${contentCtrl.htmlData}");
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(appFonts.description.tr,
                style: AppCss.outfitSemiBold18
                    .textColor(appCtrl.appTheme.primary)),
            Row(children: [
              SvgPicture.asset(eSvgAssets.share).descriptionOptionBg(),
              const HSpace(Sizes.s12),
              SvgPicture.asset(eSvgAssets.trash).descriptionOptionBg().inkWell(onTap: (){
                contentCtrl.htmlData = null;
                contentCtrl.update();
              }),
              const HSpace(Sizes.s12),
              SvgPicture.asset(eSvgAssets.copy).descriptionOptionBg().inkWell(
                  onTap: () async {
                String parsedstring3 =
                    Bidi.stripHtmlIfNeeded(contentCtrl.htmlData);
                log(parsedstring3);
                Clipboard.setData(ClipboardData(text: parsedstring3));
              }),
              const HSpace(Sizes.s12),
              SvgPicture.asset(eSvgAssets.edit).descriptionOptionBg()
            ])
          ]),
          const VSpace(Sizes.s15),
          RawScrollbar(
            controller: contentCtrl.scrollController,
            trackColor: appCtrl.appTheme.greyLight,
            thumbColor: appCtrl.appTheme.primary,
            radius: const Radius.circular(AppRadius.r4),
            thickness: 3,
            child: ListView( controller: contentCtrl.scrollController,padding: EdgeInsets.zero,children: [
              HtmlWidget(contentCtrl.htmlData,textStyle: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt).textHeight(1.5),).paddingAll(Insets.i20).decorated(
                  color: appCtrl.appTheme.bg1,
                  borderRadius: BorderRadius.circular(AppRadius.r6)),
            ]).height(contentCtrl.htmlData.length > 350 ? Sizes.s350: contentCtrl.htmlData.length > 200 ?Sizes.s180 : Sizes.s120),
          )
        ],
      );
    });
  }
}
