import 'package:firebase_auth/firebase_auth.dart';
import '../../config.dart';
import '../../widgets/scaffold_messenger.dart';

class ResetPasswordController extends GetxController {
  GlobalKey<FormState> resetPasswordGlobalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  // Reset Password Method
  onResetPassword() {
    if (resetPasswordGlobalKey.currentState!.validate()) {
      isLoading = true;
      try {
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.toString());
        isLoading = false;
        snackBarMessengers(message: appFonts.emailSend);
        Get.offAllNamed(routeName.signInScreen);
      } catch (e) {
        isLoading = false;
        snackBarMessengers(message: appFonts.unknownError);

        snackBarMessengers(message: appFonts.emailSend.tr);
        Get.offAllNamed(routeName.signInScreen);
      }
    }
  }
}
