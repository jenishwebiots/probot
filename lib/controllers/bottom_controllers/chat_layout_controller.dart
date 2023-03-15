import 'dart:developer';

import 'package:probot/bot_api/api_services.dart';
import 'package:probot/models/chat_model.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../config.dart';
import '../../models/message_model.dart';

class ChatLayoutController extends GetxController {
  dynamic data;
  int index = 0;
  List<ChatListDateWise> chatList = [];
  final chatController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String? time;
  String? receiverTime;
  int count = 0;
  int receiverCount = 0;
  int lastIndex = 0;
  int receiverLastIndex = 0;
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

    chatList =
        appArray.chatList.map((e) => ChatListDateWise.fromJson(e)).toList();
    update();
    log("chatList : $chatList");
    super.onReady();
  }

  //check sender time
  bool checkTime(givenTime, givenIndex) {
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
    messages.value.add(
      ChatMessage(
        text: chatController.text,
        chatMessageType: ChatMessageType.user,
      ),
    );
    shareMessages.add("${chatController.text} - Myself\n");
    itemCount.value = messages.value.length;
    // isLoading.value = true;

    var input = chatController.text;
    textInput.value = chatController.text;
    chatController.clear();
    update();

    Future.delayed(const Duration(milliseconds: 50)).then((_) => scrollDown());
    update();
    ApiServices.chatCompeletionResponse("Hello").then((value) {
      // isLoading.value = false
      log("messages $value");

      messages.value.add(
        ChatMessage(
          text: value.replaceFirst("\n", " ").replaceFirst("\n", " "),
          chatMessageType: ChatMessageType.bot,
        ),
      );
      shareMessages.add(
          "${value.replaceFirst("\n", " ").replaceFirst("\n", " ")} -By ADBOT\n");

      Future.delayed(
        const Duration(milliseconds: 50),
      ).then((_) => scrollDown());
      itemCount.value = messages.value.length;
    });

    chatController.clear();

    update();
  }

  //check receiver time
  bool checkReceiverTime(givenTime, givenIndex) {
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
