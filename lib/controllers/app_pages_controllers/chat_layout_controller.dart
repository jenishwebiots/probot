import 'dart:developer';

import 'package:probot/screens/app_screens/chat_layout/layouts/clear_chat_success.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/share_layout.dart';

import '../../config.dart';
import '../../models/message_model.dart';

class ChatLayoutController extends GetxController {
  dynamic data;
  int index = 0;
  List<ChatListDateWise> chatList = [];
  List backgroundList =[];
  final ScrollController scrollController = ScrollController();
  String? time;
  String? receiverTime;
  String? selectedImage;
  int count = 0;
  int receiverCount = 0;
  int lastIndex = 0;
  int receiverLastIndex = 0;

  @override
  void onReady() {
    // TODO: implement onReady
    var arg = Get.arguments;
    if (arg != null) {
      data = arg["data"];
      index = arg["index"];
    }

    chatList =
        appArray.chatList.map((e) => ChatListDateWise.fromJson(e)).toList();
    backgroundList= appArray.backgroundList;
    selectedImage = appCtrl.storage.read("backgroundImage") ?? eImageAssets.background1;
    update();
    log("chatList : $chatList");
    super.onReady();
  }

  //check sender time
  bool checkTime(givenTime, givenIndex, length, chatIndex) {
    if (time == givenTime) {
      count++;
      lastIndex = givenIndex;
      return true;
    } else {
      count = 0;
      time = givenTime;
      if (givenIndex < length - 1) {
        if (time == chatList[chatIndex].chat![givenIndex + 1].time) {
          return true;
        } else {
          lastIndex = 0;
          return false;
        }
      } else {
        return false;
      }
    }
  }

  //check receiver time
  bool checkReceiverTime(givenTime, givenIndex) {
    if (receiverTime == givenTime) {
      receiverCount++;
      receiverLastIndex = givenIndex;
      return true;
    } else {
      receiverCount = 0;
      receiverTime = givenTime;
      receiverLastIndex = 0;
      return false;
    }
  }

  PopupMenuItem buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
        value: position,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt)),
          const VSpace(Sizes.s15),
          if (position != 4)
            const Divider(
                height: 0, color: Color.fromRGBO(50, 52, 68, 0.1), thickness: 1)
        ]));
  }

  //show share dialog
  showShareDialog() {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return const Align(
          alignment: Alignment.center,
          child: ShareLayout(),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  //clear chat success
  clearChatSuccessDialog() {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return const Align(
          alignment: Alignment.center,
          child: ClearChatSuccess(),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
