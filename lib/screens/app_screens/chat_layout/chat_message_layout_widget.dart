import 'package:probot/controllers/bottom_controllers/chat_layout_controller.dart';
import 'package:probot/models/chat_model.dart';
import 'package:probot/config.dart';

class ChatMessageLayoutWidget extends StatelessWidget {
  final chatCtrl = Get.put(ChatLayoutController());

  ChatMessageLayoutWidget(
      {super.key,
      required this.text,
      required this.onSpeech,
      required this.onStop,
      required this.index,
      required this.chatMessageType});

  final String text;
  final int index;
  final ChatMessageType chatMessageType;
  final VoidCallback onSpeech, onStop;

  @override
  Widget build(BuildContext context) {
    return _chatBody(context);
  }

  _chatBody(BuildContext context) {
    if (chatMessageType == ChatMessageType.bot) {
      // bool isTimeShow = chatCtrl.checkReceiverTime(
      //     chatCtrl.chatList[index].chat![i].time, i);
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
                        image: AssetImage(
                      chatCtrl.data["image"],
                    ))),
              ),
              const HSpace(Sizes.s6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text.length > 40
                      ? Container(
                          width: 250,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Insets.i10, vertical: Insets.i12),
                          decoration: BoxDecoration(
                              color: appCtrl.appTheme.boxBg,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.r6)),
                          child: Text(
                            text,
                            overflow: TextOverflow.clip,
                            style: AppCss.outfitMedium14
                                .textColor(appCtrl.appTheme.txt)
                                .textHeight(1.2),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Insets.i10, vertical: Insets.i12),
                          decoration: BoxDecoration(
                              color: appCtrl.appTheme.boxBg,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.r6)),
                          child: Text(
                            text,
                            overflow: TextOverflow.clip,
                            style: AppCss.outfitLight12
                                .textColor(appCtrl.appTheme.txt)
                                .textHeight(1.2),
                          ),
                        ),
                  // !isTimeShow &&
                  //     chatCtrl.chatList[index]
                  //         .chat![i].time! !=
                  //         chatCtrl.chatList[index]
                  //             .chat![i + 1 <=chatCtrl.chatList[index]
                  //             .chat!.length -1 ? i + 1 :i-1 ].time!
                  //     ? Column(children: [
                  //   const VSpace(Sizes.s3),
                  //   Text(
                  //     chatCtrl.chatList[index]
                  //         .chat![i].time!,
                  //     style: AppCss.outfitMedium12
                  //         .textColor(appCtrl
                  //         .appTheme.lightText),
                  //   )
                  // ])
                  //     : chatCtrl.receiverLastIndex == i
                  //     ? Column(children: [
                  //   const VSpace(Sizes.s3),
                  //   Text(
                  //     chatCtrl
                  //         .chatList[index]
                  //         .chat![chatCtrl
                  //         .receiverLastIndex]
                  //         .time!,
                  //     style: AppCss
                  //         .outfitMedium12
                  //         .textColor(appCtrl
                  //         .appTheme
                  //         .lightText),
                  //   )
                  // ])
                  // : Container(),
                ],
              ),
            ],
          ).marginSymmetric(horizontal: Insets.i20, vertical: Insets.i5));
    } else {
      // bool isTimeShow = chatCtrl.checkTime(
      //     chatCtrl.chatList[index].chat![i].time, i);
      return Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Insets.i10, vertical: Insets.i12),
                decoration: BoxDecoration(
                    color: appCtrl.appTheme.primary,
                    borderRadius: BorderRadius.circular(AppRadius.r6)),
                child: Text(
                  "text",
                  style: AppCss.outfitMedium14
                      .textColor(appCtrl.appTheme.sameWhite),
                ),
              ),
              //  !isTimeShow  &&
              //  chatCtrl.chatList[index]
              //      .chat![i].time! !=
              //  chatCtrl.chatList[index]
              //      .chat![i + 1 <=chatCtrl.chatList[index]
              //      .chat!.length -1 ? i + 1 :i-1 ].time!
              //       ? Column(children: [
              //           const VSpace(Sizes.s3),
              //           Text(
              //             chatCtrl.chatList[index]
              //                 .chat![i].time!,
              //             style: AppCss.outfitLight12
              //                 .textColor(appCtrl
              //                     .appTheme.lightText),
              //           )
              //         ])
              //       : chatCtrl.lastIndex == i
              //           ? Column(children: [
              //               const VSpace(Sizes.s3),
              //               Text(
              //                 chatCtrl
              //                     .chatList[index]
              //                     .chat![chatCtrl
              //                         .lastIndex]
              //                     .time!,
              //                 style: AppCss
              //                     .outfitLight12
              //                     .textColor(appCtrl
              //                         .appTheme
              //                         .lightText),
              //               )
              //             ])
              //           : Container(),
            ],
          ).marginSymmetric(horizontal: Insets.i20, vertical: Insets.i5));
    }
  }
}
