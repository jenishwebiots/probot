import 'dart:developer';

import '../../../../config.dart';

class Receiver extends StatelessWidget {
  final ChatMessage? chatListModel;
  final int? dateWiseIndex, index;

  const Receiver({Key? key, this.chatListModel, this.index, this.dateWiseIndex})
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
                ChatCommonWidget().userImage(appCtrl.selectedCharacter["image"]),
                const HSpace(Sizes.s6),
                chatListModel!.chatMessageType == ChatMessageType.loading ?
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Insets.i10,),
                    decoration: BoxDecoration(
                        color: appCtrl.appTheme.boxBg,
                        boxShadow:  [
                          BoxShadow(
                              color: appCtrl.appTheme.primaryShadow,
                              offset:const Offset(0, 10),
                              blurRadius: 20)
                        ],
                        borderRadius:
                        BorderRadius.circular(AppRadius.r6)),
                    child:  Image.asset(eGifAssets.loading,height: Sizes.s40,)
                )
                    :
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      chatListModel!.text!.length > 40
                          ? ReceiverWidthText(text: chatListModel!.text!)
                          : ReceiverContent(text: chatListModel!.text!),
                      const VSpace(Sizes.s3),
                      ChatCommonWidget()
                          .timeTextLayout(chatListModel!.time!.toString())
                    ])
              ]).marginSymmetric(horizontal: Insets.i20, vertical: Insets.i5));
    });
  }
}
