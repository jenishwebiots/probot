import '../../bot_api/api_services.dart';
import '../../config.dart';

class EssayWriterController extends GetxController {
  TextEditingController essayController = TextEditingController();
  TextEditingController essayGeneratedController = TextEditingController();
  List essayTypeLists = [];
  int selectedIndex = 0;
  bool isEssayGenerated = false;
  bool isLoader = false;
  String? response = "";

  onEssayGenerated() {
    isLoader = true;
    ApiServices.chatCompeletionResponse(
        "Write a essay on ${essayController.text} in tone of ${selectedIndex == 0 ? "Informative" : selectedIndex == 1 ? "Persuade" : "Analyze"} ").then((value) {
      response = value;
      isEssayGenerated = true;
      isLoader = false;
      update();
    });
    essayController.clear();
    selectedIndex = 0;
    update();
  }

  onEssayTypeChange(index) {
    selectedIndex = index;
    update();
  }

  endEssayWriterDialog() {
    Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return AdviserDialog(
              title: appFonts.endEssayWriting,
              subTitle: appFonts.areYouEndEssayWriting,
              endOnTap: () {
                essayController.clear();
                selectedIndex = 0;
                isEssayGenerated = false;
                Get.back();
                update();
              });
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
  }

  @override
  void onReady() {
    essayTypeLists = appArray.essayTypeList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
