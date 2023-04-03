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
                /*chatHistoryCtrl.selectedIndex.asMap().entries.forEach((e) {
              chatHistoryCtrl.chatHistoryLists.removeAt(e.key);
              chatHistoryCtrl.update();
            });
            chatHistoryCtrl.chatHistoryLists.asMap().entries.forEach((e) {
              chatHistoryCtrl.selectedIndex.removeWhere((element) => element != e.value);
              chatHistoryCtrl.update();
            });*/
              }),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chatHistory")
                  .where('userId',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                      : Column(children: [
                          ...snapshot.data!.docs
                              .asMap()
                              .entries
                              .map((e) => ChatHistoryLayout(
                                    data: e.value,
                                    index: e.key,
                                    isLongPress: chatHistoryCtrl.isLongPress,
                                    onLongPressTap: () {
                                      chatHistoryCtrl.isLongPress = true;
                                      log("press: ${chatHistoryCtrl.isLongPress}");
                                      log("index: ${!chatHistoryCtrl.selectedIndex.contains(e.key)}");
                                      if (!chatHistoryCtrl.selectedIndex
                                          .contains(e.key)) {
                                        chatHistoryCtrl.selectedIndex
                                            .add(e.key);
                                        log("index2: ${chatHistoryCtrl.selectedIndex}");
                                        chatHistoryCtrl.update();
                                      }
                                      chatHistoryCtrl.update();
                                    },
                                    onTap: () {
                                      log("message");
                                      if (chatHistoryCtrl.isLongPress) {
                                        if (!chatHistoryCtrl.selectedIndex
                                            .contains(e.key)) {
                                          chatHistoryCtrl.selectedIndex
                                              .add(e.key);
                                          chatHistoryCtrl.update();
                                        } else {
                                          if (chatHistoryCtrl.selectedIndex
                                              .contains(e.key)) {
                                            chatHistoryCtrl.selectedIndex
                                                .remove(e.key);
                                            chatHistoryCtrl.update();
                                          }
                                        }
                                      }
                                      if (chatHistoryCtrl
                                          .selectedIndex.isEmpty) {
                                        chatHistoryCtrl.isLongPress == false;
                                        chatHistoryCtrl.update();
                                      }
                                    },
                                  ))
                              .toList()
                        ]).paddingSymmetric(
                          vertical: Insets.i25, horizontal: Insets.i20);
                }
              }));
    });
  }
}
