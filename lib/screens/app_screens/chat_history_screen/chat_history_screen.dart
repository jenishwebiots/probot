import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../config.dart';
import 'layouts/chat_history_app_bar.dart';
import 'layouts/chat_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatHistoryScreen extends StatelessWidget {
  final chatHistoryCtrl = Get.put(ChatHistoryController());

  ChatHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatHistoryController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: ChatHistoryAppBar(
              index: chatHistoryCtrl.selectedIndex,
              onDeleteTap: () {
                FirebaseFirestore.instance
                    .collection("chatHistory")
                    .where('userId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .get()
                    .then((value) {
                  value.docs.asMap().entries.map((e) {
                    String id = e.value.id;
                    if (chatHistoryCtrl.selectedIndex.contains(e.value.id)) {
                      FirebaseFirestore.instance
                          .collection("chatHistory")
                          .doc(e.value.id)
                          .delete();
                      chatHistoryCtrl.selectedIndex
                          .removeWhere((element) => element == id);
                      chatHistoryCtrl.update();
                    }
                  }).toList();
                  chatHistoryCtrl.update();
                });
              }),
          body: StreamBuilder(
              stream:   FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("chats")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container();
                } else if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(appCtrl.appTheme.primary),
                  )).height(MediaQuery.of(context).size.height);
                } else {
                  return snapshot.data!.docs.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(eImageAssets.notification,
                                  height: Sizes.s180),
                              const VSpace(Sizes.s20),
                              Text(appFonts.noDataFound.tr,
                                  textAlign: TextAlign.center,
                                  style: AppCss.outfitMedium14
                                      .textColor(appCtrl.appTheme.lightText)),
                            ],
                          ),
                        ).height(MediaQuery.of(context).size.height)
                      : SingleChildScrollView(
                    child: Column(children: [
                      ...snapshot.data!.docs
                          .asMap()
                          .entries
                          .map((e) => ChatHistoryLayout(
                        data: e.value,
                        isLongPress:
                        chatHistoryCtrl.isLongPress,
                        onLongPressTap: () {
                          chatHistoryCtrl.isLongPress =
                          true;
                          log("press: ${chatHistoryCtrl.isLongPress}");
                          log("index: ${!chatHistoryCtrl.selectedIndex.contains(e.value.id)}");
                          if (!chatHistoryCtrl.selectedIndex
                              .contains(e.value.id)) {
                            chatHistoryCtrl.selectedIndex
                                .add(e.value.id);
                            log("index2: ${chatHistoryCtrl.selectedIndex}");
                            chatHistoryCtrl.update();
                          }
                          chatHistoryCtrl.update();
                        },
                        onTap: () {
                          log("message ${chatHistoryCtrl.isLongPress}");
                          if (chatHistoryCtrl.isLongPress) {
                            if (!chatHistoryCtrl
                                .selectedIndex
                                .contains(e.value.id)) {
                              chatHistoryCtrl.selectedIndex
                                  .add(e.value.id);
                              chatHistoryCtrl.update();
                            } else {
                              if (chatHistoryCtrl
                                  .selectedIndex
                                  .contains(e.value.id)) {
                                chatHistoryCtrl
                                    .selectedIndex
                                    .remove(e.value.id);
                                chatHistoryCtrl.update();
                              }
                            }
                          } else {
                            Get.toNamed(
                                routeName.chatLayout,
                                arguments:
                                e.value["chatId"]);
                          }

                          if (chatHistoryCtrl
                              .selectedIndex.isEmpty) {
                            chatHistoryCtrl.isLongPress =
                            false;
                            log("selectIndex: ${chatHistoryCtrl.selectedIndex.isEmpty}");
                            chatHistoryCtrl.update();
                            Get.forceAppUpdate();
                          }
                        },
                      ))
                          .toList()
                    ]).paddingSymmetric(
                        vertical: Insets.i25,
                        horizontal: Insets.i20),
                  );
                }
              }));
    });
  }
}
