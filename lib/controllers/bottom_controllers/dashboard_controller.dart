import 'package:probot/config.dart';
import 'package:probot/screens/bottom_screens/dashboard/layouts/bottom_bar_bubble_icon.dart';

class DashboardController extends GetxController{
  int selectedIndex = 0;
  List bottomList = [];
  List<GlobalKey<BottomBarBubbleIconState>> iconsKey = [];
  final duration = const Duration(milliseconds: 500);
  late int iconCount = 0;
  late int selectedIndexBottom;
  late AnimationController animationController;
  late Tween<double> colorTween;
  late Animation<double?> animation;

//list of bottommost page
  List<Widget> widgetOptions = <Widget>[
    Text("Home"),
    Text("Chat"),
    Text("Image"),
    Text("Content"),
    Text("Setting"),
  ];


  @override
  void onReady()async {
    // TODO: implement onReady
    bottomList = appArray.bottomList;
    update();
    super.onReady();
  }

  void onButtonPressed(int index) async{

    selectedIndex = index;

    update();
  }

  //bottom nav bar tap
  onBottomTap(val) async {

    selectedIndex = val;
    update();

  }

  //on change bottom
  Future onChangeIndex(int index) async {
    if (index == selectedIndex) {
      return;
    }

    iconsKey[selectedIndex].currentState?.updateSelect(false);
    await Future.delayed(const Duration(milliseconds: 200));

    if (animationController.status == AnimationStatus.completed) {
      animationController.reverse();
    } else {
      animationController.forward();
    }

    selectedIndex = index;
    update();

    await Future.delayed(const Duration(milliseconds: 200));
    iconsKey[selectedIndex].currentState?.updateSelect(true);
  }

  void handleTextChangeFromOutside(items) {
    iconCount = items.length;

    iconsKey.clear();
    for (var i = 0; i < iconCount; i++) {
      final key = GlobalKey<BottomBarBubbleIconState>();
      iconsKey.add(key);
    }

    if (selectedIndex >= iconCount || selectedIndex < 0) {
      throw RangeError('selectedIndex is out of range');
    }
  }

  onInitCall(con){
    colorTween = Tween(begin: 0, end: 1);
    animationController =
        AnimationController(vsync: con, duration: duration);
    animation =
        colorTween.animate(animationController);

    selectedIndex = selectedIndex;
  }
}