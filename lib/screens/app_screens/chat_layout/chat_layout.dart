import 'dart:developer';

import 'package:probot/config.dart';
import 'package:probot/controllers/bottom_controllers/chat_layout_controller.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/receiver.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/sender.dart';

class ChatLayout extends StatelessWidget {
  final chatCtrl = Get.put(ChatLayoutController());

  ChatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PopupMenuItem buildPopupMenuItem(
        String title, IconData iconData, int position) {
      return PopupMenuItem(
        value: position,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt)),
            const VSpace(Sizes.s15),
            if (position != 4)
              const Divider(
                  height: 0,
                  color: Color.fromRGBO(50, 52, 68, 0.1),
                  thickness: 1)
          ],
        ),
      );
    }

    return GetBuilder<ChatLayoutController>(builder: (_) {
      return chatCtrl.data != null
          ? Scaffold(
              backgroundColor: appCtrl.appTheme.bg1,
              appBar: AppBar(
                  toolbarHeight: 70,
                  titleSpacing: 0,
                  leading: Hero(
                    tag: "chat${chatCtrl.index}",
                    child: SvgPicture.asset(eSvgAssets.leftArrow,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                                appCtrl.appTheme.sameWhite, BlendMode.srcIn))
                        .inkWell(onTap: () => Get.back()),
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: appCtrl.appTheme.primary,
                  actions: [
                    SvgPicture.asset(eSvgAssets.search),
                    PopupMenuButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          eSvgAssets.more,
                          height: Sizes.s20,
                          fit: BoxFit.fill,
                        ),
                        onSelected: (result) {
                          log("res : $result");
                        },
                        iconSize: Sizes.s20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                        ),
                        itemBuilder: (ctx) => [
                              buildPopupMenuItem(
                                  "Rebuild response", Icons.search, 0),
                              buildPopupMenuItem(
                                  "Share to friend", Icons.upload, 1),
                              buildPopupMenuItem(
                                  "Download chat", Icons.copy, 2),
                              buildPopupMenuItem(
                                  "Change background", Icons.copy, 3),
                              buildPopupMenuItem("Clear chat", Icons.copy, 4),
                            ]),
                  ],
                  title: Row(children: [
                    Container(
                      height: Sizes.s50,
                      width: Sizes.s50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                            chatCtrl.data["image"],
                          ))),
                    ),
                    const HSpace(Sizes.s10),
                    Text(chatCtrl.data["title"].toString().tr,
                        style: AppCss.outfitExtraBold22
                            .textColor(appCtrl.appTheme.sameWhite)),
                  ])),
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
                ),
              ))
          : Container();
    });
  }
}
