// Scaffold Messenger Common
import '../config.dart';

snackBarMessengers({message}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(message,
          style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.white)),
      backgroundColor: appCtrl.appTheme.error));
}
