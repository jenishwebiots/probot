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
  Rx<bool> isLoading = Rx<bool>(false);
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
          time: DateTime.now().millisecondsSinceEpoch),
    );
    shareMessages.add("${chatController.text} - Myself\n");
    itemCount.value = messages.value.length;
    update();
    Get.forceAppUpdate();
    int i = messages.value.indexWhere(
        (element) => element.chatMessageType == ChatMessageType.loading);

    if (i < 0) {
      Future.delayed(const Duration(milliseconds: 5));
      log("i : $i");
      messages.value.add(
        ChatMessage(
            text: "",
            chatMessageType: ChatMessageType.loading,
            time: DateTime.now().millisecondsSinceEpoch),
      );
      itemCount.value = messages.value.length;
      update();
    }
    textInput.value = chatController.text;

    update();

    scrollDown();
    update();
    ApiServices.chatCompeletionResponse(chatController.text).then((value) {
      // isLoading.value = false
      messages.value.removeWhere(
          (element) => element.chatMessageType == ChatMessageType.loading);

      messages.value.add(
        ChatMessage(
            text: value.replaceFirst("\n", " ").replaceFirst("\n", " "),
            chatMessageType: ChatMessageType.bot,
            time: DateTime.now().millisecondsSinceEpoch),
      );
      itemCount.value = messages.value.length;
      update();
      shareMessages.add(
          "${value.replaceFirst("\n", " ").replaceFirst("\n", " ")} -By ADBOT\n");

      scrollDown();
      isLoading.value = false;
      update();
    });
    chatController.clear();
    Get.forceAppUpdate();
    update();
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
