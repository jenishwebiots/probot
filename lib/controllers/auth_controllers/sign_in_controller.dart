import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../config.dart';
import '../../utils/general_utils.dart';

class SignInController extends GetxController {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> signInGlobalKey = GlobalKey<FormState>();
  String? userNameGoogle = "";
  String? userName = "";
  bool obscureText = true;

  //password obscure
  onObscure() {
    obscureText = !obscureText;
    update();
  }

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
    userNameGoogle = googleUser.displayName;
    isLoading = false;
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

  //sign in with apple
  signInWithApple() async {
    isLoading = true;
    update();
    try {
      final rawNonce = generateNonces();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      log("CRED : $appleCredential");
      final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
          accessToken: appleCredential.authorizationCode);

      log("AUTH : $oauthCredential");
      update();

      await FirebaseAuth.instance
          .signInWithCredential(oauthCredential)
          .then((value) {
        var signIn = FirebaseAuth.instance.currentUser;
        userName = signIn!.email;
        isLoading = false;
        update();

        appCtrl.storage.write("name", userName);
        Get.offAllNamed(routeName.selectLanguageScreen);
      });
      update();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();

      snackBarMessengers(message: e.code);
    } catch (e) {
      isLoading = false;
      update();

      log("ERROR CATHC ; $e");
    }
  }

  @override
  void onClose() {
    signInGlobalKey.currentState;
    // TODO: implement onClose
    super.onClose();
  }
}
