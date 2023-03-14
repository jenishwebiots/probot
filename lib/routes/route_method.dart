import '../config.dart';
import '../screens/auth_screens/select_character_screen/select_character_screen.dart';
import '../screens/auth_screens/select_language_screen/select_language_screen.dart';
import '../screens/auth_screens/sign_in_screen/sign_in_screen.dart';
import '../screens/bottom_screens/dashboard/dashboard.dart';



RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(name: _routeName.splashScreen, page: () => SplashScreen()),
    GetPage(name: _routeName.onBoardingScreen, page: () => OnBoardingScreen()),
    GetPage(name: _routeName.loginScreen, page: () => LoginScreen()),
    GetPage(name: _routeName.signInScreen, page: () => SignInScreen()),
    GetPage(
        name: _routeName.restPasswordScreen, page: () => RestPasswordScreen()),
    GetPage(
        name: _routeName.changePasswordScreen,
        page: () => ChangePasswordScreen()),
    GetPage(name: _routeName.signUpScreen, page: () => SignUpScreen()),
    GetPage(
        name: _routeName.selectLanguageScreen,
        page: () => SelectLanguageScreen()),
    GetPage(
        name: _routeName.selectCharacterScreen,
        page: () => SelectCharacterScreen()),

    GetPage(
        name: _routeName.addFingerprintScreen,
        page: () => AddFingerprintScreen()),
    GetPage(
        name: _routeName.dashboard,
        page: () => Dashboard()),



    GetPage(name: _routeName.scanFingerprintScreen, page: () => ScanFingerprintScreen()),
    GetPage(name: _routeName.notificationScreen, page: () => NotificationScreen()),

  ];
}
