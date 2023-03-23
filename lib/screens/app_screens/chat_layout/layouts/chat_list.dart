import '../../../../config.dart';

class ChatList extends StatelessWidget {
  final int? index;
  const ChatList({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return ListView.builder(
          shrinkWrap: true,
          controller: chatCtrl.scrollController,
          itemCount: chatCtrl.itemCount.value,
          itemBuilder: (context, i) {
            if (chatCtrl.messages.value[i].chatMessageType ==
                    ChatMessageType.bot ||
                chatCtrl.messages.value[i].chatMessageType ==
                    ChatMessageType.loading) {
              return Receiver(
                chatListModel: chatCtrl.messages.value[i],
                dateWiseIndex: index,
                index: i,
              );
            } else {
              return Sender(
                chatListModel: chatCtrl.messages.value[i],
                dateWiseIndex: index,
                index: i,
              );
            }
          });
    });
  }
}
