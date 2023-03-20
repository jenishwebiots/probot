import '../../config.dart';

class MyAccountController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  String? name,userName,firebaseUser;

  @override
  void onReady() {

    emailController.addListener(() {update();});
    firstNameController.addListener(() {update();});
    firstNameController.addListener(() {update();});

    emailController.text = "shanayajohn@gmail.com";
    firstNameController.text = "Shanaya";
    lastNameController.text = "John";

    name = appCtrl.storage.read("name");
    userName = appCtrl.storage.read("userName");
    firebaseUser = appCtrl.storage.read("firebaseUser");

    update();
    // TODO: implement onReady
    super.onReady();
  }
}