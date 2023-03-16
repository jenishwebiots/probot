import '../../../../config.dart';

class Receiver extends StatelessWidget {
  final ChatMessage? chatListModel;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatCommonWidget().userImage(chatCtrl.data["image"]),
                const HSpace(Sizes.s6),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  chatListModel!.text!.length > 40
                      ? ReceiverWidthText(text: chatListModel!.text!)
                      : ReceiverContent(text: chatListModel!.text!),
                  !isTimeShow! &&
                          chatListModel!.time! !=
                              chatCtrl
                                  .chatList
                                  .value[dateWiseIndex!]
                                  .chat![index! + 1 <=
                                          chatCtrl
                                                  .chatList
                                                  .value[dateWiseIndex!]
                                                  .chat!
                                                  .length -
                                              1
                                      ? index! + 1
                                      : index! - 1]
                                  .time!
                      ? Column(children: [
                          const VSpace(Sizes.s3),
                          ChatCommonWidget()
                              .timeTextLayout(chatListModel!.time!.toString())
                        ])
                      : chatCtrl.receiverLastIndex == index!
                          ? Column(children: [
                              const VSpace(Sizes.s3),
                              ChatCommonWidget().timeTextLayout(chatCtrl
                                  .chatList
                                  .value[dateWiseIndex!]
                                  .chat![chatCtrl.receiverLastIndex]
                                  .time!
                                  .toString())
                            ])
                          : Container()
                ])
              ]).marginSymmetric(horizontal: Insets.i20, vertical: Insets.i5));
    });
  }
}
