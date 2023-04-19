

import '../../config.dart';

class PasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  double value = 11;
  double strengthValue = 0;
  List passwordTypeLists = [];
  List passwordStrengthLists = [];
  int selectedIndex = 0;
  bool isPasswordGenerated = false;

  onChangePasswordType (index) {
    selectedIndex = index;
    update();
  }

  onPasswordGenerate () {
    isPasswordGenerated = true;
    update();
  }

  endPasswordGeneratorDialog() {
    Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return AdviserDialog(title: appFonts.endPasswordGenerator,subTitle: appFonts.areYouSureEndPasswordGenerator,endOnTap: () {
            isPasswordGenerated = false;
            Get.back();
            update();
          });
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300)
    );
  }


  @override
  void onReady() {
    passwordStrengthLists = appArray.passwordStrengthList;
    passwordTypeLists = appArray.passwordTypeList;
    update();
    // TODO: implement onReady
    super.onReady();
  }

}