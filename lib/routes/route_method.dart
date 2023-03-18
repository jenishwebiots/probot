import 'package:probot/screens/app_screens/chat_layout/layouts/background_list.dart';
import '../config.dart';
import '../screens/app_screens/add_fingerprint_screen/add_fingerprint_screen.dart';
import '../screens/app_screens/fingerprint_and_lock_security/fingerprint_and_lock_security.dart';
import '../screens/app_screens/my_account_screen/my_account_screen.dart';
import '../screens/app_screens/notification_screen/notification_screen.dart';


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
        name: _routeName.dashboard,
        page: () => Dashboard()),
    GetPage(
        name: _routeName.chatLayout,
        page: () => ChatLayout()),



    GetPage(name: _routeName.addFingerprintScreen, page: () => AddFingerprintScreen()),
    GetPage(name: _routeName.notificationsScreen, page: () => NotificationsScreen()),
    GetPage(name: _routeName.imagePreview, page: () => ImagePreview()),
    GetPage(name: _routeName.backgroundList, page: () =>const BackgroundList()),
    GetPage(name: _routeName.myAccountScreen, page: () => MyAccountScreen()),
    GetPage(name: _routeName.notificationScreen, page: () => NotificationScreen()),
    GetPage(name: _routeName.fingerprintAndLockSecurity, page: () => FingerprintAndLockSecurity()),

  ];
}
