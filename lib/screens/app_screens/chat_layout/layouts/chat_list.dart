import '../../../../config.dart';

class ChatList extends StatelessWidget {
  final int? index;
  const ChatList({Key? key,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: chatCtrl.chatList.value[index!].chat!.length,
          itemBuilder: (context, i) {
            if (chatCtrl.chatList.value[index!].chat![i].chatMessageType ==
                ChatMessageType.bot) {
              bool isTimeShow = chatCtrl.checkReceiverTime(
                  chatCtrl.chatList.value[index!].chat![i].time, i);
              return Receiver(
                chatListModel: chatCtrl.chatList.value[index!].chat![i],
                dateWiseIndex: index,
                index: i,
                isTimeShow: isTimeShow,
              );
            } else {
              bool isTimeShow = chatCtrl.checkTime(
                  chatCtrl.chatList.value[index!].chat![i].time,
                  i,
                  chatCtrl.chatList.value[index!].chat!.length,
                  index);

              return Sender(
                  chatListModel: chatCtrl.chatList.value[index!].chat![i],
                  dateWiseIndex: index,
                  index: i,
                  isTimeShow: isTimeShow);
            }
          });
    });
  }
}
