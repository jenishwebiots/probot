import 'package:intl/intl.dart';
import 'package:probot/config.dart';

class ChatLayout extends StatelessWidget {
  final chatCtrl = Get.put(ChatLayoutController());

  ChatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (_) {
      return chatCtrl.data != null
          ? DirectionalityRtl(
            child: Scaffold(
                backgroundColor: appCtrl.appTheme.bg1,
                appBar: const ChatScreenAppBar(),
                body: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              controller: chatCtrl.scrollController,
                              itemCount: chatCtrl.itemCount.value,
                              itemBuilder: (context, index) {
                                if (index == chatCtrl.itemCount.value) {
                                  return Container(
                                    height: 70,
                                  );
                                }
                                return Column(children: [
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(chatCtrl
                                                .chatList.value[index].dateTime!
                                                .toString()))),
                                    style: AppCss.outfitMedium14
                                        .textColor(appCtrl.appTheme.lightText),
                                  ).marginSymmetric(vertical: Insets.i15),
                                  ChatList(index: index)
                                ]);
                              }),
                        ),
                      ),
                      Container(),
                      const ChatTextBox()
                    ],
                  ).backgroundImage(DecorationImage(
                      image: AssetImage(
                          chatCtrl.selectedImage ?? eImageAssets.background2),
                      fit: BoxFit.fill)),
                )),
          )
          : Container();
    });
  }
}
