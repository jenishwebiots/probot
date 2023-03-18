import 'dart:developer';

import 'package:flutter/services.dart';

import 'package:local_auth/local_auth.dart';

import '../../config.dart';
import '../../widgets/alert_dialog_common.dart';

class AddFingerprintController extends GetxController {
  LocalAuthentication auth = LocalAuthentication();

  onBiometric() async {
    final bool isBiometricsAvailable = await auth.isDeviceSupported();
    if (isBiometricsAvailable) {
      try {
        return await auth
            .authenticate(
                localizedReason: 'Scan Fingerprint To Enter Vault',
                options: const AuthenticationOptions(
                    useErrorDialogs: true, stickyAuth: true))
            .then((value) => showDialog(
          barrierDismissible: false,
                      context: Get.context!,
          builder: (context) {
            return  AlertDialogCommon(
                image: eImageAssets.success,
                bText1: appFonts.done,
                title: appFonts.successfullyVerify,
                subtext: appFonts.yourFingerprintHasBeenVerify
            );
          },

            ));
      } on PlatformException {
        showDialog(
            barrierDismissible: false,
            context: Get.context!, builder: (context) {
         return AlertDialogCommon(
              image: eImageAssets.noSearch,
              bText1: appFonts.tryAgain,
              title: appFonts.fingerprintError,
              subtext: appFonts.sorryFingerprint
          );
        });
      }
    } else {
      log("Device Not Supported");
    }
  }

  @override
  void onReady() async {
    onBiometric();
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
