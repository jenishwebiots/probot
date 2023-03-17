import 'dart:developer';
import 'package:probot/config.dart';
import 'package:probot/screens/app_screens/chat_layout/chat_message_layout_widget.dart';
import 'package:intl/intl.dart';

class ChatLayout extends StatelessWidget {
  final chatCtrl = Get.put(ChatLayoutController());

  ChatLayout({Key? key}) : super(key: key);

  _buildLayout() {
    // var languageList = LocalStorage.getLanguage();
    return Obx(
      () => ListView.builder(
        controller: chatCtrl.scrollController,
        itemCount: chatCtrl.itemCount.value,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ChatMessageLayoutWidget(
            onStop: () {
              chatCtrl.speechStopMethod();
            },
            onSpeech: () {
              // chatCtrl.speechMethod(chatCtrl.messages.value[index].text,
              //     '${languageList[0]}-${languageList[1]}');
              // chatCtrl.voiceSelectedIndex.value = index;
            },
            text: chatCtrl.messages.value[index].text!,
            chatMessageType: chatCtrl.messages.value[index].chatMessageType!,
            index: index,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (_) {
      return chatCtrl.data != null
          ? DirectionalityRtl(
              child: Scaffold(
                  backgroundColor: appCtrl.appTheme.bg1,
                  appBar: const ChatScreenAppBar(),
                  body: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: Column(
                      children: [
                        Text(
                          "Today, ${DateFormat("hh:mm a").format(DateTime.now())}",
                          style: AppCss.outfitMedium14
                              .textColor(appCtrl.appTheme.lightText),
                        ),
                        const VSpace(Sizes.s13),
                        const Expanded(
                          child: ChatList(),
                        ),
                        Container(),
                        const ChatTextBox()
                      ],
                    )
                        .backgroundImage(DecorationImage(
                            image: AssetImage(chatCtrl.selectedImage ??
                                eImageAssets.background2),
                            fit: BoxFit.fill))
                        .marginOnly(top: Insets.i15),
                  )),
            )
          : Container();
    });
  }
}
