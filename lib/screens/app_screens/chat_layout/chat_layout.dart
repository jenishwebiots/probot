import 'dart:developer';
import 'package:probot/config.dart';
import 'package:probot/controllers/bottom_controllers/chat_layout_controller.dart';
import 'package:probot/screens/app_screens/chat_layout/chat_message_layout_widget.dart';

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
            text: chatCtrl.messages.value[index].text,
            chatMessageType: chatCtrl.messages.value[index].chatMessageType,
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
                Expanded(
                  flex: 1,
                  child: _buildLayout(),
                ),
                const Text("Submit")
                    .inkWell(onTap: () => chatCtrl.proccessChat()),
                const VSpace(Sizes.s10),
              ]))
          : Container();
    });
  }
}
