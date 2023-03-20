
import 'package:probot/config.dart';
import 'package:probot/screens/bottom_screens/content_writer/content_writer.dart';

import '../../screens/bottom_screens/image_generator/image_generator.dart';



class DashboardController extends GetxController with GetTickerProviderStateMixin{

  int selectedIndex = 0;
  List bottomList = [];
  TabController? con;

  List<AnimationController>? animationControllers;
  List<Animation>? animation;
  final duration = const Duration(milliseconds: 500);
  late int iconCount = 0;
  late int selectedIndexBottom;
  late AnimationController animationController;
  late Tween<double> colorTween;
  final chatLayoutCtrl = Get.isRegistered<ChatLayoutController>() ? Get.find<ChatLayoutController>(): Get.put(ChatLayoutController());

//list of bottommost page
  List<Widget> widgetOptions = <Widget>[
    Home(),
    ChatLayout(),
    ImageGenerator(),
    ContentWriter(),
    Setting(),
  ];

  @override
  void onReady() async {
    // TODO: implement onReady
    con = TabController(vsync: this, length: 5, initialIndex: 0)
      ..addListener(listener);
    animationControllers = List.generate(5, (i) {
      return AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 750),
          reverseDuration: const Duration(milliseconds: 350));
    });
    bottomList = appArray.bottomList;
    update();
    chatLayoutCtrl.onReady();
    chatLayoutCtrl.update();
    super.onReady();
  }

  void listener() {
    if (con!.indexIsChanging) {
      animationControllers![con!.previousIndex].reverse();
    } else {
      animationControllers![con!.index].forward();
    }
    update();
  }

  //bottom nav bar tap
  onBottomTap(val) async {
    selectedIndex = val;
    con!.index = val;
    con!.addListener(listener);
    update();
    if(selectedIndex == 1){
      chatLayoutCtrl.    showInterstitialAd();
    }
  }

  @override
  void dispose() {
    super.dispose();
    con!
      ..removeListener(listener)
      ..dispose();
    for (var ac in animationControllers!) {
      ac.dispose();
    }
  }
}
