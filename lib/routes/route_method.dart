
import 'package:probot/screens/app_screens/add_api_key_screen/add_api_key_screen.dart';
import 'package:probot/screens/app_screens/allow_notification_screen/allow_notification_screen.dart';
import 'package:probot/widgets/common_web_view.dart';
import 'package:probot/widgets/no_internet.dart';
import 'package:probot/screens/app_screens/code_generator_screen/code_generator_screen.dart';
import 'package:probot/screens/app_screens/music_for_post_screen/music_for_post_screen.dart';
import 'package:probot/screens/app_screens/personal_advisor_screen/personal_advisor_screen.dart';
import 'package:probot/screens/app_screens/social_media_screen/social_media_screen.dart';


import '../config.dart';
import '../screens/app_screens/amazon_product_feature_screen/amazon_product_feature_screen.dart';
import '../screens/app_screens/amazon_product_listing/amazon_product_listing.dart';

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
        page: () =>  SubscriptionPlan()),
    GetPage(name: _routeName.chatHistory, page: () => ChatHistoryScreen()),
    GetPage(name: _routeName.inAppList, page: () => InAppList()),
    GetPage(name: _routeName.quickAdvisor, page: () => QuickAdvisorScreen()),
    GetPage(name: _routeName.translateScreen, page: () =>  TranslateScreen()),
    GetPage(name: _routeName.commonWebView, page: () => const CommonWebView()),
    GetPage(name: _routeName.noInternet, page: () => const NoInternet()),

    GetPage(name: _routeName.translateScreen, page: () => TranslateScreen()),
    GetPage(
        name: _routeName.codeGeneratorScreen,
        page: () => CodeGeneratorScreen()),
    GetPage(
        name: _routeName.emailWriterScreen, page: () => EmailGeneratorScreen()),
    GetPage(
        name: _routeName.socialMediaScreen, page: () => SocialMediaScreen()),
    GetPage(
        name: _routeName.captionCreatorScreen,
        page: () => CaptionCreatorScreen()),
    GetPage(
        name: _routeName.musicForPostScreen, page: () => MusicForPostScreen()),
    GetPage(
        name: _routeName.hashtagForPostScreen,
        page: () => HashtagForPostScreen()),
    GetPage(
        name: _routeName.passwordGeneratorScreen,
        page: () => PasswordGeneratorScreen()),
    GetPage(
        name: _routeName.essayWriterScreen, page: () => EssayWriterScreen()),
    GetPage(name: _routeName.travelScreen, page: () => TravelScreen()),
    GetPage(
        name: _routeName.nearbyPointsScreen, page: () => NearbyPointsScreen()),
    GetPage(
        name: _routeName.distanceAttractionScreen,
        page: () => DistanceAttractionScreen()),
    GetPage(
        name: _routeName.personalAdvisorScreen,
        page: () => PersonalAdvisorScreen()),
    GetPage(name: _routeName.babyNameScreen, page: () => BabyNameScreen()),
    GetPage(name: _routeName.cvMakerScreen, page: () => CvMakerScreen()),
    GetPage(
        name: _routeName.giftSuggestionScreen,
        page: () => GiftSuggestionScreen()),
    GetPage(
        name: _routeName.birthdayMessageScreen,
        page: () => BirthdayMessageScreen()),
    GetPage(
        name: _routeName.anniversaryMessageScreen,
        page: () => AnniversaryMessageScreen()),

    GetPage(name: _routeName.newBabyWishesScreen,page: () => NewBabyWishesScreen()),
    GetPage(name: _routeName.getWellMessageScreen,page: () => GetWellMessageScreen()),

    GetPage(
        name: _routeName.newBabyWishesScreen,
        page: () => NewBabyWishesScreen()),
    GetPage(name: _routeName.translateScreen, page: () => TranslateScreen()),
    GetPage(name: _routeName.commonWebView, page: () => const CommonWebView()),
    GetPage(name: _routeName.noInternet, page: () => const NoInternet()),
    GetPage(name: _routeName.valentineScreen, page: () => ValentineDayScreen()),
    GetPage(name: _routeName.newYearGreetingScreen, page: () => NewYearGreetingScreen()),
    GetPage(name: _routeName.mothersDayWishesScreen, page: () => MothersDayWishesScreen()),
    GetPage(name: _routeName.fathersDayWishesScreen, page: () => FathersDayWishesScreen()),
    GetPage(name: _routeName.promotionWishesScreen, page: () => PromotionWishesScreen()),
    GetPage(name: _routeName.babyShowerScreen, page: () => BabyShowerScreen()),
    GetPage(name: _routeName.farewellMessageScreen, page: () => FarewellMessageScreen()),
    GetPage(name: _routeName.weddingWishesScreen, page: () => WeddingWishesScreen()),
    GetPage(name: _routeName.manageApiKeyScreen, page: () => ManageApiKeyScreen()),
    GetPage(name: _routeName.balanceTopUp, page: () => BalanceTopUp()),
    GetPage(name: _routeName.addApiKeyScreen, page: () => AddApiKeyScreen()),

    GetPage(name: _routeName.viewSubscription, page: () =>const ViewSubscription()),
    GetPage(name: _routeName.contentWriterScreen, page: () => ContentWriterScreen()),

    GetPage(name: _routeName.settingScreen, page: () => Setting()),
    GetPage(name: _routeName.allowNotificationScreen, page: () => AllowNotificationScreen()),
    GetPage(name: _routeName.amazonProductFeatureScreen, page: () => AmazonProductFeatureScreen()),
    GetPage(name: _routeName.amazonProductListingScreen, page: () => AmazonProductListingScreen()),

  ];
}
