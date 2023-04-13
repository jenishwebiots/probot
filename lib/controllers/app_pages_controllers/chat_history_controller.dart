import 'package:probot/config.dart';

class ChatHistoryController extends GetxController {

  List chatHistoryLists = [];
  bool isLongPress = false;
  List selectedIndex = [];
  List selectedData = [];

  @override
  void onReady() {
    chatHistoryLists = appArray.chatHistoryList;
    update();
    // TODO: implement onReady
    super.onReady();
  }


  //pop up menu item
  PopupMenuItem buildPopupMenuItem(
      String title,int position) {
    return PopupMenuItem(
        value: position,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt)),
          const VSpace(Sizes.s15),
          if (position != 1)
            Divider(height: 0, color: appCtrl.appTheme.greyLight, thickness: 1)
        ]));
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