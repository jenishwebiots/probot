import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:probot/screens/bottom_screens/chat_layout/layouts/guest_receiver.dart';
import 'package:probot/screens/bottom_screens/chat_layout/layouts/guest_sender.dart';

import '../../../../config.dart';

class ChatList extends StatelessWidget {
  final int? index;

  const ChatList({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return appCtrl.isGuestLogin
          ? InkWell(
              onTap: () {
                chatCtrl.isLongPress = false;
                chatCtrl.selectedData = [];
                chatCtrl.selectedIndex = [];

                chatCtrl.update();
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    controller: chatCtrl.scrollController,
                    itemCount: chatCtrl.itemCount.value,
                    itemBuilder: (context, i) {
                      if (chatCtrl.messages.value[i].chatMessageType ==
                              ChatMessageType.bot ||
                          chatCtrl.messages.value[i].chatMessageType ==
                              ChatMessageType.loading) {
                        return GuestReceiver(
                          chatListModel: chatCtrl.messages.value[i],
                          index: i,
                        );
                      } else {
                        return GuestSender(
                          chatListModel: chatCtrl.messages.value[i],
                          index: i,
                        );
                      }
                    }),
              ),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chatHistory")
                  .doc(chatCtrl.chatId)
                  .collection("chats")
                  .orderBy("createdDate", descending: false)
                  .snapshots(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  return InkWell(
                    onTap: () {
                      chatCtrl.isLongPress = false;
                      chatCtrl.selectedData = [];
                      chatCtrl.selectedIndex = [];
                      chatCtrl.update();
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          controller: chatCtrl.scrollController,
                          itemCount: snapShot.data!.docs.length,
                          itemBuilder: (context, i) {
                            if (snapShot.data!.docs[i].data()["messageType"] ==
                                    ChatMessageType.bot.name ||
                                snapShot.data!.docs[i].data()["messageType"] ==
                                    ChatMessageType.loading.name) {
                              return Receiver(
                                chatListModel: snapShot.data!.docs[i].data(),
                                index: i,
                              );
                            } else {
                              return Sender(
                                chatListModel: snapShot.data!.docs[i].data(),
                                index: i,
                              );
                            }
                          }),
                    ),
                  );
                } else {
                  return Container();
                }
              });
    });
  }
}
