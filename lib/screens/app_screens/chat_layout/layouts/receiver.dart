
import 'package:probot/models/message_model.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/receiver_content.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/receiver_width_text.dart';

import '../../../../config.dart';

class Receiver extends StatelessWidget {
  final ChatListModel? chatListModel;
  final int? dateWiseIndex, index;
  final bool? isTimeShow;

  const Receiver(
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
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Sizes.s40,
                width: Sizes.s40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(chatCtrl.data["image"]))),
              ),
              const HSpace(Sizes.s6),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                chatCtrl.chatList[dateWiseIndex!].chat![index!].message!
                            .length >
                        40
                    ? ReceiverWidthText(text: chatListModel!.message!)
                    : ReceiverContent(text: chatListModel!.message!),
                !isTimeShow! &&
                        chatListModel!.time! !=
                            chatCtrl
                                .chatList[dateWiseIndex!]
                                .chat![index! + 1 <=
                                        chatCtrl.chatList[dateWiseIndex!].chat!
                                                .length -
                                            1
                                    ? index! + 1
                                    : index! - 1]
                                .time!
                    ? Column(children: [
                        const VSpace(Sizes.s3),
                        Text(chatListModel!.time!,
                            style: AppCss.outfitMedium12
                                .textColor(appCtrl.appTheme.lightText))
                      ])
                    : chatCtrl.receiverLastIndex == index!
                        ? Column(children: [
                            const VSpace(Sizes.s3),
                            Text(
                                chatCtrl.chatList[dateWiseIndex!]
                                    .chat![chatCtrl.receiverLastIndex].time!,
                                style: AppCss.outfitMedium12
                                    .textColor(appCtrl.appTheme.lightText))
                          ])
                        : Container()
              ])
            ],
          ).marginSymmetric(horizontal: Insets.i20, vertical: Insets.i5));
    });
  }
}
