import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../config.dart';

class ChatHistoryAppBar extends StatelessWidget with PreferredSizeWidget {
  final List? index;
  final GestureTapCallback? onDeleteTap,onMenuTap;
  const ChatHistoryAppBar({Key? key,this.index,this.onDeleteTap,this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatHistoryController>(builder: (chatCtrl) {
        return AppBar(
          elevation: 0,
            toolbarHeight: 70,
            titleSpacing: 0,
            leading: SvgPicture.asset(
              eSvgAssets.leftArrow,
              fit: BoxFit.scaleDown,
              colorFilter:
              ColorFilter.mode(appCtrl.appTheme.sameWhite, BlendMode.srcIn),
            ).inkWell(onTap: () {
              Get.back();
            }),
            automaticallyImplyLeading: false,
            backgroundColor: appCtrl.appTheme.primary,
            actions: [
              index!.isNotEmpty ? SvgPicture.asset(eSvgAssets.delete).paddingSymmetric(horizontal: Insets.i15).inkWell(onTap: onDeleteTap) :
              StreamBuilder(
                  stream: FirebaseFirestore.instance
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                appCtrl.appTheme.primary),
                          )).height(MediaQuery
                          .of(context)
                          .size
                          .height);
                    } else {
                      return PopupMenuButton(
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(eSvgAssets.more,
                              height: Sizes.s20, fit: BoxFit.fill),
                          onSelected: (result) async {
                            log("res : $result");

                            if (result == 0) {
                              chatCtrl.isLongPress = true;
                              snapshot.data!
                                  .docs
                                  .asMap()
                                  .entries
                                  .forEach((element) {
                                if (!chatCtrl.selectedIndex
                                    .contains(element.value.id)) {
                                  chatCtrl.selectedIndex
                                      .add(element.value.id);
                                  log("index2: ${chatCtrl.selectedIndex}");
                                  chatCtrl.update();

                                }
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("chats")
                                  .get()
                                  .then((value) {
                                snapshot.data!
                                    .docs
                                    .asMap()
                                    .entries
                                    .forEach((element) {
                                  FirebaseFirestore.instance.collection(
                                      "chatHistory")
                                      .doc(element.value.id)
                                      .delete().then((value) {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .collection("chats").doc(element.value.id).delete();
                                  });
                                });
                              });
                              chatCtrl.selectedIndex = [];
                              chatCtrl.update();
                              chatCtrl.clearChatSuccessDialog();
                            }
                          },
                          iconSize: Sizes.s20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                          ),
                          itemBuilder: (ctx) =>
                          [
                            chatCtrl.buildPopupMenuItem(
                                appFonts.selectAll.tr, 0),
                            chatCtrl.buildPopupMenuItem(
                                appFonts.clearAll.tr, 1)
                          ]);
                    }
                  }),
            ],
            title: Text( index!.isNotEmpty ? "${index!.length} Selected" : appFonts.chatHistory.tr,
                style: AppCss.outfitExtraBold22
                    .textColor(appCtrl.appTheme.sameWhite)));
      }
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}
