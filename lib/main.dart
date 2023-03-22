import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'common/languages/index.dart';
import 'common/theme/app_theme.dart';
import 'common/theme/theme_service.dart';
import 'config.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51MmFV9SEDxC6QpAR9J3jRuq98kMjTJ2ngACQ2gF9ToN4VRdMPIwCtC9fPIRqx17PFiCZJxaQ5lMG5Isif1RB9LC900ljSZTd50";
  await Firebase.initializeApp();
//  Get.put(AppController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
         themeMode: ThemeService().theme,
        theme: AppTheme.fromType(ThemeType.light).themeData,
        darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
        locale: const Locale('en', 'US'),
        translations: Language(),
        fallbackLocale: const Locale('en', 'US'),
        home: SplashScreen(),
        title: appFonts.proBot.tr,
        getPages: appRoute.getPages,
        debugShowCheckedModeBanner: false);
  }
}
