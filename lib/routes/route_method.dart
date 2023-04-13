import 'package:probot/screens/app_screens/code_generator_screen/code_generator_screen.dart';
import 'package:probot/screens/app_screens/music_for_post_screen/music_for_post_screen.dart';
import 'package:probot/screens/app_screens/social_media_screen/social_media_screen.dart';

import '../config.dart';
import '../screens/app_screens/caption_creator_screen/caption_creator_screen.dart';
import '../screens/app_screens/email_generator_screen/email_generator_screen.dart';
import '../screens/app_screens/hashtag_for_post_screen/hashtag_for_post_screen.dart';

RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(name: _routeName.splashScreen, page: () => SplashScreen()),
    GetPage(name: _routeName.onBoardingScreen, page: () => OnBoardingScreen()),
    GetPage(name: _routeName.loginScreen, page: () => const LoginScreen()),
    GetPage(name: _routeName.signInScreen, page: () => const SignInScreen()),
    GetPage(
        name: _routeName.restPasswordScreen, page: () => RestPasswordScreen()),
    GetPage(
        name: _routeName.changePasswordScreen,
        page: () => const ChangePasswordScreen()),
    GetPage(name: _routeName.signUpScreen, page: () => const SignUpScreen()),
    GetPage(
        name: _routeName.selectLanguageScreen,
        page: () => SelectLanguageScreen()),
    GetPage(
        name: _routeName.selectCharacterScreen,
        page: () => SelectCharacterScreen()),
    GetPage(name: _routeName.mobileLogin, page: () => MobileLogin()),
    GetPage(name: _routeName.dashboard, page: () => Dashboard()),
    GetPage(name: _routeName.chatLayout, page: () => ChatLayout()),
    GetPage(
        name: _routeName.addFingerprintScreen,
        page: () => AddFingerprintScreen()),
    GetPage(
        name: _routeName.notificationsScreen,
        page: () => NotificationsScreen()),
    GetPage(name: _routeName.imagePreview, page: () => ImagePreview()),
    GetPage(
        name: _routeName.backgroundList, page: () => const BackgroundList()),
    GetPage(name: _routeName.myAccountScreen, page: () => MyAccountScreen()),
    GetPage(
        name: _routeName.fingerprintAndLockSecurity,
        page: () => const FingerprintAndLockSecurity()),
    GetPage(
        name: _routeName.privacyPolicyScreen,
        page: () => PrivacyPolicyScreen()),
    GetPage(name: _routeName.subscriptionPlanList, page: () => Subscription()),
    GetPage(
        name: _routeName.subscriptionPlan,
        page: () => const SubscriptionPlan()),
    GetPage(name: _routeName.chatHistory, page: () => ChatHistoryScreen()),
    GetPage(name: _routeName.inAppList, page: () => InAppList()),
    GetPage(name: _routeName.quickAdvisor, page: () => QuickAdvisorScreen()),
    GetPage(name: _routeName.translateScreen, page: () => TranslateScreen()),
    GetPage(
        name: _routeName.codeGeneratorScreen,
        page: () => CodeGeneratorScreen()),
    GetPage(
        name: _routeName.emailWriterScreen, page: () => EmailGeneratorScreen()),
    GetPage(
        name: _routeName.socialMediaScreen, page: () => SocialMediaScreen()),
    GetPage(name: _routeName.captionCreatorScreen, page: () => CaptionCreatorScreen()),
    GetPage(name: _routeName.musicForPostScreen, page: () => MusicForPostScreen()),
    GetPage(name: _routeName.hashtagForPostScreen, page: () => HashtagForPostScreen()),
  ];
}
