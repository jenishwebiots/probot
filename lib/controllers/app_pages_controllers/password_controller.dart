import '../../bot_api/api_services.dart';
import '../../config.dart';

class PasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  double value = 11;
  double strengthValue = 0;
  List passwordTypeLists = [];
  List passwordStrengthLists = [];
  int selectedIndex = 0;
  bool isPasswordGenerated = false;
  bool isLoader = false;
  String? response;

  onChangePasswordType(index) {
    selectedIndex = index;
    update();
  }

  onPasswordGenerate() {
    int balance = appCtrl.envConfig["balance"];
    if(balance == 0){
      appCtrl.balanceTopUpDialog();
    }else {
      addCtrl.onInterstitialAdShow();
      isLoader = true;
      ApiServices.chatCompeletionResponse(
          "Create password which length of $value and password type of ${passwordTypeLists[selectedIndex]} and password strength is ${passwordStrengthLists[strengthValue
              .toInt()]} ")
          .then((value) {
        response = value;
        isPasswordGenerated = true;
        isLoader = false;
        update();
      });
      update();
    }
  }

  endPasswordGeneratorDialog() {
    Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return AdviserDialog(
              title: appFonts.endPasswordGenerator,
              subTitle: appFonts.areYouSureEndPasswordGenerator,
              endOnTap: () {
                value = 11;
                strengthValue = 0;
                selectedIndex = 0;
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
        transitionDuration: const Duration(milliseconds: 300));
  }

  @override
  void onReady() {
    addCtrl.onInterstitialAdShow();
    passwordStrengthLists = appArray.passwordStrengthList;
    passwordTypeLists = appArray.passwordTypeList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
