import 'dart:developer';

import 'package:flutter/services.dart';

import 'package:local_auth/local_auth.dart';

import '../../config.dart';
import '../../widgets/alert_dialog_common.dart';
import '../../widgets/scaffold_messenger.dart';

class AddFingerprintController extends GetxController {
  LocalAuthentication auth = LocalAuthentication();
  String authorized = " not authorized";
  bool canCheckBiometric = false;
  List<BiometricType> availableBiometric = [];


  /*onBiometric() async {
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
                subtext: appFonts.yourFingerprintHasBeenVerify,
              b1OnTap: ()=> Get.offAllNamed(routeName.dashboard),
              crossOnTap: ()=> Get.offAllNamed(routeName.dashboard)
                );
               }
            ));
      } on PlatformException {
        showDialog(
            barrierDismissible: false,
            context: Get.context!, builder: (context) {
         return AlertDialogCommon(
              image: eImageAssets.noSearch,
              bText1: appFonts.tryAgain,
              title: appFonts.fingerprintError,
              subtext: appFonts.sorryFingerprint,
           b1OnTap: ()=> Get.offAllNamed(routeName.fingerprintAndLockSecurity),
           crossOnTap: ()=> Get.offAllNamed(routeName.fingerprintAndLockSecurity)
          );
        });
      }
    } else {
      snackBarMessengers(message: appFonts.deviceNotSupported);
    }
  }*/


  Future<void> authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
          localizedReason: "Scan your finger to authenticate",
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: true));
      authenticated ? showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) {
            return  AlertDialogCommon(
                image: eImageAssets.success,
                bText1: appFonts.done,
                title: appFonts.successfullyVerify,
                subtext: appFonts.yourFingerprintHasBeenVerify,
                b1OnTap: () {
                  appCtrl.storage.write("isBiometric", authenticated);
                  Get.offAllNamed(routeName.dashboard);
                },
                crossOnTap: () {
                  appCtrl.storage.write("isBiometric", authenticated);
                  Get.offAllNamed(routeName.dashboard);
                }
            );
          }
      ) : showDialog(
          barrierDismissible: false,
          context: Get.context!, builder: (context) {
        return AlertDialogCommon(
            image: eImageAssets.noSearch,
            bText1: appFonts.tryAgain,
            title: appFonts.fingerprintError,
            subtext: appFonts.sorryFingerprint,
            b1OnTap: ()=> Get.offAllNamed(routeName.fingerprintAndLockSecurity),
            crossOnTap: ()=> Get.offAllNamed(routeName.fingerprintAndLockSecurity)
        );
      });
      update();
    } on PlatformException  {
      snackBarMessengers(message: appFonts.deviceNotSupported);
    }
    update();

  }

  Future<void> checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      update();
    } on PlatformException catch (e) {
      print("checkBiometric: $e");
    }

    if (!isClosed) return;
    canCheckBiometric = canCheckBiometric;
    update();
  }

  Future getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
      update();
    } on PlatformException catch (e) {
      print("getAvailableBiometric: $e");
    }
    availableBiometric = availableBiometric;
    update();
  }



  @override
  void onReady() async {
    // onBiometric();
    checkBiometric();
    getAvailableBiometric();
    authenticate();
    update();
    // TODO: implement onReady
    super.onReady();
  }
}