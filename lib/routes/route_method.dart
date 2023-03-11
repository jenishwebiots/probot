import '../config.dart';


RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(name: _routeName.splashScreen, page: () => SplashScreen()),
    GetPage(name: _routeName.onBoardingScreen, page: () => OnBoardingScreen()),
    GetPage(name: _routeName.loginScreen, page: () => LoginScreen()),
    GetPage(name: _routeName.signInScreen, page: () => SignInScreen()),

  ];
}

