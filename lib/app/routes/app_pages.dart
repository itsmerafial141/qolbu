import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/memorize/bindings/memorize_binding.dart';
import '../modules/memorize/views/memorize_view.dart';
import '../modules/navigation/bindings/navigation_binding.dart';
import '../modules/navigation/views/navigation_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/recite/bindings/recite_binding.dart';
import '../modules/recite/views/recite_view.dart';
import '../modules/retain/bindings/retain_binding.dart';
import '../modules/retain/views/retain_view.dart';
import '../modules/save/bindings/save_binding.dart';
import '../modules/save/views/save_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/surah/bindings/surah_binding.dart';
import '../modules/surah/views/surah_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => const NavigationView(),
      binding: NavigationBinding(),
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        MemorizeBinding(),
        ReciteBinding(),
        RetainBinding(),
        SaveBinding(),
      ],
    ),
    GetPage(
      name: _Paths.MEMORIZE,
      page: () => const MemorizeView(),
      binding: MemorizeBinding(),
    ),
    GetPage(
      name: _Paths.RECITE,
      page: () => const ReciteView(),
      binding: ReciteBinding(),
    ),
    GetPage(
      name: _Paths.RETAIN,
      page: () => const RetainView(),
      binding: RetainBinding(),
    ),
    GetPage(
      name: _Paths.SAVE,
      page: () => const SaveView(),
      binding: SaveBinding(),
    ),
    GetPage(
      name: _Paths.SURAH,
      page: () => const SurahView(),
      binding: SurahBinding(),
    ),
  ];
}
