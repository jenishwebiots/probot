import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../config.dart';
import '../../widgets/scaffold_messenger.dart';

class SignInController extends GetxController {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> signInGlobalKey = GlobalKey<FormState>();
  String? userNameGoogle = "";
  String? userName = "";

  // SignIn With Google Method
  Future<UserCredential> signInWithGoogle() async {
    log("message");
    isLoading = true;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    log("googleUser $googleUser");
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
      log("googleAuth  $googleAuth");
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    log("credential $credential");
    /* userEmail = googleUser.email;
    userName = googleUser.displayName;
    userPhoto = googleUser.photoUrl;
    update();
    var data ={
      "userData": googleUser,
      "type":"google"
    };*/
    userNameGoogle = googleUser.displayName;
    isLoading = false;
    /* appCtrl.storage.write("name", userName);
    appCtrl.storage.write("email", userEmail);
    appCtrl.storage.write("photo", userPhoto);*/
    appCtrl.storage.write("userName", userNameGoogle);
    Get.offAllNamed(routeName.selectLanguageScreen);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Sign In With Email & Password Method
  signInMethod() async {
    if (signInGlobalKey.currentState!.validate()) {
      isLoading = true;
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString());

        var signIn = FirebaseAuth.instance.currentUser;
         userName = signIn!.email;
        update();
        isLoading = false;
        appCtrl.storage.write("name", userName);
        Get.offAllNamed(routeName.selectLanguageScreen);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          isLoading = false;
          snackBarMessengers(message: appFonts.wrongPassword);
        } else if (e.code == 'user-not-found') {
          isLoading = false;
          snackBarMessengers(message: appFonts.userNotFound);
        }
      } catch (e) {
        isLoading = false;
        snackBarMessengers(message: appFonts.unknownError);
      }
    }
  }
}
