import 'package:probot/config.dart';

class QuickAdvisorController extends GetxController {
  List quickAdvisorLists = [];

  @override
  void onReady() {
    quickAdvisorLists = appArray.quickAdvisor;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}