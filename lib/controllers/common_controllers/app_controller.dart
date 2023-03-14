import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../common/theme/app_theme.dart';

class AppController extends GetxController {
  AppTheme _appTheme = AppTheme.fromType(ThemeType.light);
  AppTheme get appTheme => _appTheme;
  String priceSymbol = "\$";
  bool isTheme = false;
  bool isRTL = false;
  bool isLanguage = false;
  bool isCharacter = false;
  String languageVal = "in";
  final storage = GetStorage();
 // double currencyVal = double.parse(appArray.language[0]["INR"].toString());
  bool isSwitched = false;
  bool isOnboard = false;
  dynamic currency;
  //update theme
  updateTheme(theme) {
    _appTheme = theme;
    Get.forceAppUpdate();
  }

}
