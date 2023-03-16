import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:probot/bot_api/api_services.dart';
import 'package:probot/models/chat_model.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:probot/screens/app_screens/chat_layout/layouts/clear_chat_success.dart';

import '../../config.dart';
import '../../models/message_model.dart';
import '../../screens/app_screens/chat_layout/layouts/share_layout.dart';

class ChatLayoutController extends GetxController {
  dynamic data;
  int index = 0;
  List backgroundList = [];
  Rx<List<ChatListDateWise>> chatList = Rx<List<ChatListDateWise>>([]);
  final chatController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String? time;
  DateTime? receiverTime;
  int count = 0;
  int receiverCount = 0;
  int lastIndex = 0;
  int receiverLastIndex = 0;
  String? selectedImage;

  Rx<List<ChatMessage>> messages = Rx<List<ChatMessage>>([]);
  final FlutterTts? flutterTts = FlutterTts();
  final _isSpeech = false.obs;
  List<String> shareMessages = ['--THIS IS CONVERSATION with ADBOT--\n\n'];
  RxInt itemCount = 0.obs;
  RxString textInput = ''.obs;
  final _isSpeechLoading = false.obs;

  RxInt chatCount = 0.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    var arg = Get.arguments;
    if (arg != null) {
      data = arg["data"];
      index = arg["index"];
    }
    backgroundList = appArray.backgroundList;
    selectedImage =
        appCtrl.storage.read("backgroundImage") ?? eImageAssets.background1;
    /* chatList =
        appArray.chatList.map((e) => ChatListDateWise.fromJson(e)).toList();*/
    update();
    log("chatList : $chatList");
    super.onReady();
  }

  //check sender time
  bool checkTime(givenTime, givenIndex, length, chatIndex) {
    /*if (time == givenTime) {
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
    }*/
    return false;
  }

  speechMethod(String text, String language) async {
    _isSpeechLoading.value = true;
    _isSpeech.value = true;
    update();

    await flutterTts!.setLanguage(language);
    await flutterTts!.setPitch(1);
    await flutterTts!.setSpeechRate(0.45);
    await flutterTts!.speak(text);

    Future.delayed(
        const Duration(seconds: 2), () => _isSpeechLoading.value = false);
    update();
  }

  speechStopMethod() async {
    _isSpeech.value = false;
    await flutterTts!.stop();
    update();
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  addTextCount() async {
    debugPrint("-------${chatCount.value.toString()}--------");
    chatCount.value++;
    // LocalStorage.saveTextCount(count: chatCount.value);
  }

  proccessChat() async {
    speechStopMethod();
    addTextCount();

    if (chatList.value.isNotEmpty) {
      chatList.value.asMap().entries.forEach((element) {
        if (DateFormat("dd/MM/yyyy").format(DateTime.now()) ==
            DateFormat('dd/MM/yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(element.value.dateTime.toString())))) {
          element.value.chat!.add(ChatMessage(
              text: chatController.text,
              chatMessageType: ChatMessageType.user,
              time: DateTime.now().millisecondsSinceEpoch));
        }
      });
    }else{
      messages.value.add(
        ChatMessage(
            text: chatController.text,
            chatMessageType: ChatMessageType.user,
            time: DateTime.now().millisecondsSinceEpoch),
      );
      chatList.value.add(ChatListDateWise(
          dateTime: DateTime.now().millisecondsSinceEpoch,
          chat: messages.value));
    }
    shareMessages.add("${chatController.text} - Myself\n");
    itemCount.value = chatList.value.length;
    // isLoading.value = true;

    var input = chatController.text;
    textInput.value = chatController.text;

    update();

    Future.delayed(const Duration(milliseconds: 50)).then((_) => scrollDown());
    update();
    ApiServices.chatCompeletionResponse(chatController.text).then((value) {
      // isLoading.value = false

      chatList.value.asMap().entries.forEach((element) {
        log("AVAILABLE : ${DateFormat("dd/MM/yyyy").format(DateTime.now()) ==
            DateFormat('dd/MM/yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(element.value.dateTime.toString())))}");
        if (DateFormat("dd/MM/yyyy").format(DateTime.now()) ==
            DateFormat('dd/MM/yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(element.value.dateTime.toString())))) {
          element.value.chat!.add(ChatMessage(
              text: value.replaceFirst("\n", " ").replaceFirst("\n", " "),
              chatMessageType: ChatMessageType.bot,
              time: DateTime.now().millisecondsSinceEpoch));
          log("element.value : ${element.value.chat!.length}");
        } else {
          messages.value.add(
            ChatMessage(
                text: value.replaceFirst("\n", " ").replaceFirst("\n", " "),
                chatMessageType: ChatMessageType.bot,
                time: DateTime.now().millisecondsSinceEpoch),
          );
          chatList.value.add(ChatListDateWise(
              dateTime: DateTime.now().millisecondsSinceEpoch,
              chat: messages.value));

          log("element.value : ${element.value.chat!.length}");
        }
      });
      itemCount.value = chatList.value.length;
      log("messagesmessages : ${itemCount.value}");
      update();
      shareMessages.add(
          "${value.replaceFirst("\n", " ").replaceFirst("\n", " ")} -By ADBOT\n");

      Future.delayed(
        const Duration(milliseconds: 50),
      ).then((_) => scrollDown());
    });
    chatController.clear();
    Get.forceAppUpdate();
    update();
  }

  //check receiver time
  bool checkReceiverTime(givenTime, givenIndex) {
/*    log("isCH : ${receiverTime == givenTime}");
    if (receiverTime == givenTime) {
      receiverCount++;
      receiverLastIndex = givenIndex;
      return true;
    } else {
      receiverCount = 0;
      receiverTime = givenTime;
      receiverLastIndex = 0;
      return false;
    }*/
    return false;
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
