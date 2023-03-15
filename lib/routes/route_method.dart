

import '../config.dart';



RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(name: _routeName.splashScreen, page: () => SplashScreen()),
    GetPage(name: _routeName.onBoardingScreen, page: () => OnBoardingScreen()),
    GetPage(name: _routeName.loginScreen, page: () => const LoginScreen()),
    GetPage(name: _routeName.signInScreen, page: () => SignInScreen()),
    GetPage(
        name: _routeName.restPasswordScreen, page: () => RestPasswordScreen()),
    GetPage(
        name: _routeName.changePasswordScreen,
        page: () => const ChangePasswordScreen()),
    GetPage(name: _routeName.signUpScreen, page: () => SignUpScreen()),
    GetPage(
        name: _routeName.selectLanguageScreen,
        page: () => SelectLanguageScreen()),
    GetPage(
        name: _routeName.selectCharacterScreen,
        page: () => SelectCharacterScreen()),

    GetPage(
        name: _routeName.addFingerprintScreen,
        page: () => const AddFingerprintScreen()),
    GetPage(
        name: _routeName.dashboard,
        page: () => Dashboard()),
    GetPage(
        name: _routeName.chatLayout,
        page: () => ChatLayout()),



    GetPage(name: _routeName.scanFingerprintScreen, page: () => const ScanFingerprintScreen()),
    GetPage(name: _routeName.notificationScreen, page: () => NotificationScreen()),

  ];
}
