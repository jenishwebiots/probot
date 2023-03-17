import 'dart:developer';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:probot/bot_api/api_services.dart';
import 'package:probot/models/content_model.dart';
import '../../config.dart';

class ContentWriterController extends GetxController {
  String? selectedValue = "businessIdea";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List contentOptionList = [];
  Rx<List<ContentMessage>> messages = Rx<List<ContentMessage>>([]);
  final contentController = TextEditingController();
  RxString contentInput = ''.obs;
  RxInt itemCount = 0.obs;
  List<String> shareMessages = ['--THIS IS CONVERSATION with ADBOT--\n\n'];
  RxInt contentCount = 0.obs;
  final FlutterTts? flutterTts = FlutterTts();
  final contentScrollController = ScrollController();

  final isSpeechLoading = false.obs;
  final isSpeech = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    contentOptionList = appArray.contentOptionList;
    update();
    super.onReady();
  }

  //on option tap function
  onOptionTap(index) {
    final dashboardCtrl = Get.find<DashboardController>();
    if (index == 0) {
      dashboardCtrl.onBottomTap(1);
    } else if (index == 1) {
      dashboardCtrl.onBottomTap(2);
    } else {
      dashboardCtrl.onBottomTap(3);
    }
    dashboardCtrl.update();
  }

  speechStopMethod() async {
    isSpeech.value = false;
    await flutterTts!.stop();
    update();
  }

  void scrollDown() {
    contentScrollController.animateTo(
      contentScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  addTextCount() async {
    contentCount.value++;
    // LocalStorage.saveTextCount(count: count.value);
  }

  void proccessContentWrite() async {
    speechStopMethod();
    addTextCount();
    messages.value.add(
      ContentMessage(
        text: contentController.text,
        textMessageType: ContentMessageType.user,
      ),
    );
    shareMessages.add("${contentController.text} - Myself\n");
    itemCount.value = messages.value.length;

    var input = contentController.text;
    contentInput.value = contentController.text;
    contentController.clear();
    update();

    Future.delayed(const Duration(milliseconds: 50)).then((_) => scrollDown());
    update();

    ApiServices.textCompletionResponse(input).then((value) {
      messages.value.add(
        ContentMessage(
          text: value.replaceFirst("\n", " ").replaceFirst("\n", " "),
          textMessageType: ContentMessageType.bot,
        ),
      );
      shareMessages.add(
          "${value.replaceFirst("\n", " ").replaceFirst("\n", " ")} -By ADBOT\n");
      Future.delayed(
        const Duration(milliseconds: 50),
      ).then((_) => scrollDown());
      itemCount.value = messages.value.length;
    });
    contentController.clear();
    update();
  }
}
