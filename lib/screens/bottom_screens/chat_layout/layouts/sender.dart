

import 'package:intl/intl.dart';
import 'package:probot/widgets/common_volume.dart';

import '../../../../config.dart';

class Sender extends StatelessWidget {
  final dynamic chatListModel;
  final int? dateWiseIndex, index;

  const Sender({Key? key, this.chatListModel, this.index, this.dateWiseIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  chatListModel["message"].length > 40
                      ? SenderWidthText(
                          text: chatListModel["message"],
                          index: index,
                          time: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('hh:mm a').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(chatListModel["createdDate"]
                                              .toString()))),
                                  style: AppCss.outfitMedium12
                                      .textColor(appCtrl.appTheme.sameWhite),
                                ),
                                CommonVolume(message: chatListModel["message"])
                              ]),
                        )
                      : CommonContent(
                          text: chatListModel["message"],
                          index: index,
                          time: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('hh:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(chatListModel["createdDate"]
                                            .toString()))),
                                style: AppCss.outfitMedium12
                                    .textColor(appCtrl.appTheme.sameWhite),
                              ),
                              const HSpace(Sizes.s15),
                              CommonVolume(message: chatListModel["message"])
                            ],
                          )),
                  const VSpace(Sizes.s3),
                ],
              ).marginSymmetric(horizontal: Insets.i20, vertical: Insets.i5))
          .onLongPressTap(onLongPress: () {
        chatCtrl.isLongPress = true;
        if (!chatCtrl.selectedIndex.contains(index)) {
          chatCtrl.selectedIndex.add(index);
          chatCtrl.selectedData.add(chatCtrl.selectedMessages[index!]);
          chatCtrl.update();
        }
      });
    });
  }
}
