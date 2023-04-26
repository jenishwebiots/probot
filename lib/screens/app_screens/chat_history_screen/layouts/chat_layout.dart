import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../../config.dart';
import 'package:intl/intl.dart';

class ChatHistoryLayout extends StatelessWidget {
  final dynamic data;
  final GestureLongPressCallback? onLongPressTap;
  final GestureTapCallback? onTap;
  final bool? isLongPress;
  final int? index;

  const ChatHistoryLayout(
      {Key? key,
      this.data,
      this.onLongPressTap,
      this.isLongPress = false,
      this.onTap,
      this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatHistoryController>(builder: (chatHistoryCtrl) {
      log("HISTR L: ${data}");
      return SizedBox(
        child: Row(children: [
          Stack(alignment: Alignment.bottomRight, children: [
            CachedNetworkImage(
                imageUrl: data["avatar"],
                height: Sizes.s44,
                width: Sizes.s50,
                fit: BoxFit.fill,
                imageBuilder: (context, imageProvider) => SizedBox(
                    height: Sizes.s44,
                    width: Sizes.s50,
                    child: Column(children: [
                      Image.network(
                          data["avatar"].toString(),
                          height: Sizes.s40,
                          width: Sizes.s40,
                          fit: BoxFit.fill)
                    ])),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.network(
                    appCtrl.selectedCharacter["image"].toString(),
                    height: Sizes.s40,
                    width: Sizes.s40,
                    fit: BoxFit.fill)),
            if (chatHistoryCtrl.selectedIndex.contains(index))
              SvgPicture.asset(eSvgAssets.tick)
          ]),
          const HSpace(Sizes.s10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(data["message"].toString().tr,
                    style: AppCss.outfitMedium14
                        .textColor(appCtrl.appTheme.txt)
                        .textHeight(1.2)),
                const VSpace(Sizes.s5),
                Text(
                    DateFormat('hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            int.parse(data["createdDate"].toString()))),
                    style: AppCss.outfitMedium12
                        .textColor(appCtrl.appTheme.lightText))
              ]))
        ])
            .padding(
                horizontal: Insets.i15, top: Insets.i15, bottom: Insets.i12)
            .inkWell(onTap: onTap),
      )
          .decorated(
              color: chatHistoryCtrl.selectedIndex.contains(data["id"])
                  ? appCtrl.appTheme.primaryLight
                  : appCtrl.appTheme.boxBg,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r10)))
          .paddingOnly(bottom: Insets.i15)
          .onLongPressTap(onLongPress: onLongPressTap);
    });
  }
}
