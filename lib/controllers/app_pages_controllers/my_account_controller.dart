
import '../../config.dart';

class MyAccountController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  String? name,userName,firebaseUser;

  @override
  void onReady() {

    emailController.text = appCtrl.storage.read("userName");
    userName = emailController.text;
    firstNameController.text = appCtrl.storage.read("name") ??"";
    name = firstNameController.text;

   // firebaseUser = appCtrl.storage.read("firebaseUser");

    update();
    // TODO: implement onReady
    super.onReady();
  }
}