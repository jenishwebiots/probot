import 'dart:developer';

import 'package:probot/config.dart';
import 'package:probot/controllers/bottom_controllers/chat_layout_controller.dart';

class ChatLayout extends StatelessWidget {
  final chatCtrl = Get.put(ChatLayoutController());

  ChatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                title: Row(
                  children: [
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
                  ],
                ),
              ),
              body: Column(children: [
                ListView.builder(
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
                        Text(chatCtrl.chatList[index].dateTime!,style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText),)
                            .marginSymmetric(vertical: Insets.i15),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: chatCtrl.chatList[index].chat!.length,
                            itemBuilder: (context, i) {
                              if (chatCtrl
                                  .chatList[index].chat![i].isReceiver!) {
                                bool isTimeShow = chatCtrl.checkReceiverTime(
                                    chatCtrl.chatList[index].chat![i].time, i);
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
                                            chatCtrl.chatList[index].chat![i]
                                                        .message!.length >
                                                    40
                                                ? Container(
                                                    width: 250,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: Insets.i10,
                                                        vertical: Insets.i12),
                                                    decoration: BoxDecoration(
                                                        color: appCtrl
                                                            .appTheme.boxBg,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppRadius
                                                                        .r6)),
                                                    child: Text(
                                                      chatCtrl.chatList[index]
                                                          .chat![i].message!,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: AppCss
                                                          .outfitMedium14
                                                          .textColor(appCtrl
                                                              .appTheme.txt)
                                                          .textHeight(1.2),
                                                    ),
                                                  )
                                                : Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: Insets.i10,
                                                        vertical: Insets.i12),
                                                    decoration: BoxDecoration(
                                                        color: appCtrl
                                                            .appTheme.boxBg,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppRadius
                                                                        .r6)),
                                                    child: Text(
                                                      chatCtrl.chatList[index]
                                                          .chat![i].message!,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: AppCss
                                                          .outfitLight12
                                                          .textColor(appCtrl
                                                              .appTheme.txt)
                                                          .textHeight(1.2),
                                                    ),
                                                  ),
                                            !isTimeShow &&
                                                chatCtrl.chatList[index]
                                                    .chat![i].time! !=
                                                    chatCtrl.chatList[index]
                                                        .chat![i + 1 <=chatCtrl.chatList[index]
                                                        .chat!.length -1 ? i + 1 :i-1 ].time!
                                                ? Column(children: [
                                              const VSpace(Sizes.s3),
                                              Text(
                                                chatCtrl.chatList[index]
                                                    .chat![i].time!,
                                                style: AppCss.outfitMedium12
                                                    .textColor(appCtrl
                                                    .appTheme.lightText),
                                              )
                                            ])
                                                : chatCtrl.receiverLastIndex == i
                                                ? Column(children: [
                                              const VSpace(Sizes.s3),
                                              Text(
                                                chatCtrl
                                                    .chatList[index]
                                                    .chat![chatCtrl
                                                    .receiverLastIndex]
                                                    .time!,
                                                style: AppCss
                                                    .outfitMedium12
                                                    .textColor(appCtrl
                                                    .appTheme
                                                    .lightText),
                                              )
                                            ])
                                                : Container(),
                                          ],
                                        ),
                                      ],
                                    ).marginSymmetric(
                                        horizontal: Insets.i20,
                                        vertical: Insets.i5));
                              } else {
                                bool isTimeShow = chatCtrl.checkTime(
                                    chatCtrl.chatList[index].chat![i].time, i);
                                return Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Insets.i10,
                                              vertical: Insets.i12),
                                          decoration: BoxDecoration(
                                              color: appCtrl.appTheme.primary,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppRadius.r6)),
                                          child: Text(
                                            chatCtrl.chatList[index].chat![i]
                                                .message!,
                                            style: AppCss.outfitMedium14
                                                .textColor(
                                                    appCtrl.appTheme.sameWhite),
                                          ),
                                        ),
                                       !isTimeShow  &&
                                       chatCtrl.chatList[index]
                                           .chat![i].time! !=
                                       chatCtrl.chatList[index]
                                           .chat![i + 1 <=chatCtrl.chatList[index]
                                           .chat!.length -1 ? i + 1 :i-1 ].time!
                                            ? Column(children: [
                                                const VSpace(Sizes.s3),
                                                Text(
                                                  chatCtrl.chatList[index]
                                                      .chat![i].time!,
                                                  style: AppCss.outfitLight12
                                                      .textColor(appCtrl
                                                          .appTheme.lightText),
                                                )
                                              ])
                                            : chatCtrl.lastIndex == i
                                                ? Column(children: [
                                                    const VSpace(Sizes.s3),
                                                    Text(
                                                      chatCtrl
                                                          .chatList[index]
                                                          .chat![chatCtrl
                                                              .lastIndex]
                                                          .time!,
                                                      style: AppCss
                                                          .outfitLight12
                                                          .textColor(appCtrl
                                                              .appTheme
                                                              .lightText),
                                                    )
                                                  ])
                                                : Container(),
                                      ],
                                    ).marginSymmetric(
                                        horizontal: Insets.i20,
                                        vertical: Insets.i5));
                              }
                            })
                      ]);
                    })
              ]))
          : Container();
    });
  }
}
