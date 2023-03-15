
import 'package:probot/screens/app_screens/chat_layout/layouts/sender_content.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/sender_width_text.dart';


import '../../../../config.dart';
import '../../../../models/message_model.dart';

class Sender extends StatelessWidget {
  final ChatListModel? chatListModel;
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
              chatCtrl.chatList[dateWiseIndex!].chat![index!].message!
                  .length >
                  40
                  ? SenderWidthText(text: chatListModel!.message!)
                  :  CommonContent(text: chatCtrl.chatList[dateWiseIndex!].chat![index!].message!),
              !isTimeShow!
                  ? Column(children: [
                      const VSpace(Sizes.s3),
                      Text(
                        chatCtrl.chatList[dateWiseIndex!].chat![index!].time!,
                        style: AppCss.outfitMedium12
                            .textColor(appCtrl.appTheme.lightText),
                      )
                    ])
                  : chatCtrl.lastIndex == index!
                      ? Column(children: [
                          const VSpace(Sizes.s3),
                          Text(
                            chatCtrl.chatList[dateWiseIndex!]
                                .chat![chatCtrl.lastIndex].time!,
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
