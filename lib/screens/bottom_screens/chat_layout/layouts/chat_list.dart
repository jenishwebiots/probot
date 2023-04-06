import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../config.dart';

class ChatList extends StatelessWidget {
  final int? index;
  const ChatList({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {

      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chatHistory")
            .doc(chatCtrl.chatId)
            .collection("chats").snapshots(),
        builder: (context,snapShot) {
          if(snapShot.hasData) {
            return InkWell(
              onTap: () {
                chatCtrl.isLongPress = false;
                chatCtrl.selectedData = [];
                chatCtrl.selectedIndex = [];

                chatCtrl.update();
              },
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  controller: chatCtrl.scrollController,
                  itemCount: snapShot.data!.docs.length,
                  itemBuilder: (context, i) {

                    if (snapShot.data!.docs[i].data()["isSender"] == false) {
                      return Receiver(
                        chatListModel:snapShot.data!.docs[i].data(),
                        index: i,
                      );
                    } else {
                      return Sender(
                        chatListModel:snapShot.data!.docs[i].data(),
                        index: i,);
                    }
                  }),
            );
          }else{
            return Container();
          }
        }
      );
    });
  }
}
