import 'package:probot/config.dart';


class SplashController extends GetxController {
@override
  void onReady() {
  Future.delayed(const Duration(seconds: 3),() {
    Get.toNamed(routeName.onBoardingScreen);
    update();
  });
    // TODO: implement onReady
    super.onReady();
  }
}