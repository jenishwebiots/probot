import 'dart:developer';

import '../../config.dart';
import '../../models/message_model.dart';

class ChatLayoutController extends GetxController {
  dynamic data;
  int index = 0;
  List<ChatListDateWise> chatList = [];
  final ScrollController scrollController = ScrollController();
  String? time;
  String? receiverTime;
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
    update();
    log("chatList : $chatList");
    super.onReady();
  }

  //check sender time
  bool checkTime(givenTime,givenIndex) {
    log("isCH : ${time == givenTime}");
    if (time == givenTime) {
      count++;
      lastIndex = givenIndex;
      return true;
    } else {
      count = 0;
      time = givenTime;
      lastIndex = 0;
      return false;
    }
  }

  //check receiver time
  bool checkReceiverTime(givenTime,givenIndex) {
    log("isCH : ${receiverTime == givenTime}");
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
}
