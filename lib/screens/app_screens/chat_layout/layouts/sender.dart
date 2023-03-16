import 'package:intl/intl.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/sender_content.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/sender_width_text.dart';

import '../../../../config.dart';
import '../../../../models/message_model.dart';

class Sender extends StatelessWidget {
  final ChatMessage? chatListModel;
  final int? dateWiseIndex, index;
  final bool? isTimeShow;

  const Sender(
      {Key? key,
      this.chatListModel,
      this.index,
      this.dateWiseIndex,
      this.isTimeShow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              chatListModel!.text!.length > 40
                  ? SenderWidthText(text: chatListModel!.text!)
                  : CommonContent(text: chatListModel!.text!),
              !isTimeShow!
                  ? Column(children: [
                      const VSpace(Sizes.s3),
                      Text(
                        DateFormat('hh:mm a').format(
                            DateTime.fromMillisecondsSinceEpoch(int.parse(
                                chatCtrl.chatList.value[dateWiseIndex!]
                                    .chat![index!].time!
                                    .toString()))),
                        style: AppCss.outfitMedium12
                            .textColor(appCtrl.appTheme.lightText),
                      )
                    ])
                  : chatCtrl.lastIndex == index!
                      ? Column(children: [
                          const VSpace(Sizes.s3),
                          Text(
                            DateFormat('hh:mm a').format(
                                DateTime.fromMillisecondsSinceEpoch(int.parse(
                                    chatCtrl.chatList.value[dateWiseIndex!]
                                        .chat![chatCtrl.lastIndex].time!
                                        .toString()))),
                            style: AppCss.outfitMedium12
                                .textColor(appCtrl.appTheme.lightText),
                          )
                        ])
                      : Container(),
            ],
          ).marginSymmetric(horizontal: Insets.i20, vertical: Insets.i5));
    });
  }
}
