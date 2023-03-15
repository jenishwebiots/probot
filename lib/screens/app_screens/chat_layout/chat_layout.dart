import 'dart:developer';

import 'package:probot/config.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/chat_screen_app_bar.dart';

import 'package:probot/screens/app_screens/chat_layout/layouts/receiver.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/sender.dart';

class ChatLayout extends StatelessWidget {
  final chatCtrl = Get.put(ChatLayoutController());

  ChatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ChatLayoutController>(builder: (_) {
      return chatCtrl.data != null
          ? Scaffold(

              backgroundColor: appCtrl.appTheme.bg1,
              appBar:const ChatScreenAppBar(),
              body: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: Column(
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: chatCtrl.scrollController,
                            itemCount: chatCtrl.chatList.length,
                            itemBuilder: (context, index) {
                              if (index == chatCtrl.chatList.length) {
                                return Container(
                                  height: 70,
                                );
                              }
                              return Column(children: [
                                Text(
                                  chatCtrl.chatList[index].dateTime!,
                                  style: AppCss.outfitMedium14
                                      .textColor(appCtrl.appTheme.lightText),
                                ).marginSymmetric(vertical: Insets.i15),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        chatCtrl.chatList[index].chat!.length,
                                    itemBuilder: (context, i) {
                                      if (chatCtrl.chatList[index].chat![i]
                                          .isReceiver!) {
                                        bool isTimeShow =
                                            chatCtrl.checkReceiverTime(
                                                chatCtrl.chatList[index]
                                                    .chat![i].time,
                                                i);
                                        return Receiver(
                                          chatListModel:
                                              chatCtrl.chatList[index].chat![i],
                                          dateWiseIndex: index,
                                          index: i,
                                          isTimeShow: isTimeShow,
                                        );
                                      } else {
                                        bool isTimeShow = chatCtrl.checkTime(
                                            chatCtrl
                                                .chatList[index].chat![i].time,
                                            i,
                                            chatCtrl
                                                .chatList[index].chat!.length,
                                            index);

                                        return Sender(
                                            chatListModel: chatCtrl
                                                .chatList[index].chat![i],
                                            dateWiseIndex: index,
                                            index: i,
                                            isTimeShow: isTimeShow);
                                      }
                                    })
                              ]);
                            }),
                      ),
                    ),
                    Container(),
                    TextFieldCommon(
                      hintText: "Type here...",
                      fillColor: appCtrl.isTheme
                          ? appCtrl.appTheme.bg
                          : appCtrl.appTheme.white,
                      prefixIcon: SvgPicture.asset(eSvgAssets.smile)
                          .paddingOnly(left: Insets.i18, right: Insets.i10),
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(eSvgAssets.mic),
                          const HSpace(Sizes.s12),
                          SvgPicture.asset(eSvgAssets.send)
                              .paddingAll(Insets.i6)
                              .decorated(
                                  color: appCtrl.appTheme.primary,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r6)),
                          const HSpace(Sizes.s8),
                        ],
                      ),
                    ).paddingOnly(
                        bottom: Insets.i20, left: Insets.i20, right: Insets.i20)
                  ],
                ).backgroundImage(DecorationImage(image: AssetImage(chatCtrl.selectedImage ?? eImageAssets.background2),fit: BoxFit.fill)),
              ))
          : Container();
    });
  }
}
