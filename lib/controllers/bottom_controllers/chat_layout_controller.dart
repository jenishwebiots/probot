import 'dart:developer';

import '../../config.dart';
import '../../models/message_model.dart';

class ChatLayoutController extends GetxController {
 dynamic data;
 int index=0;
 List<ChatListDateWise> chatList =[];
 final ScrollController scrollController = ScrollController();


  @override
  void onReady() {
    // TODO: implement onReady
    var arg = Get.arguments;
    if(arg != null){
      data = arg["data"];
      index = arg["index"];
    }

    chatList = appArray.chatList.map((e) => ChatListDateWise.fromJson(e)).toList();
    update();
    log("chatList : $chatList");
    super.onReady();
  }
}
