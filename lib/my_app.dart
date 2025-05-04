import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:qolbu/app/routes/app_pages.dart';
import 'package:qolbu/core/languages/localization_utilities.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/main_theme.dart';
import 'package:qolbu/core/themes/theme_manager.dart';
import 'package:qolbu/core/values/enums/flavor_enum.dart';
import 'package:qolbu/services/flavor_service.dart';

ThemeManager themeManager = ThemeManager();
bool connection = true;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void dispose() {
    themeManager.removeListener(_themeListener);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(_themeListener);
    _checkConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_connectionChange);
    super.initState();
  }

  void _checkConnectivity() async {
    await _connectivity.checkConnectivity().then(_connectionChange);
  }

  void _themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _connectionChange(List<ConnectivityResult> event) {
    if (event.contains(ConnectivityResult.none)) {
      connection = false;
    } else {
      connection = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: _screenUtilBuilder,
    );
  }

  Widget _screenUtilBuilder(_, __) {
    return GetMaterialApp(
      title: "Qolbu",
      translations: Localization(),
      locale: const Locale("id", "ID"),
      fallbackLocale: const Locale('id', 'ID'),
      initialBinding: SplashScreenBinding(),
      initialRoute: Routes.SPLASH_SCREEN,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('id')],
      builder: _getMaterialAppBuilder,
    );
  }

  Widget _getMaterialAppBuilder(BuildContext context, Widget? child) {
    var data = MediaQuery.of(context);
    return switch (FlavorServices.instance.flavor) {
      Flavor.DEVELOPMENT => _mediaQuary(data, child),
      Flavor.STAGING => _mediaQuary(data, child),
      Flavor.PRODUCTION => _mediaQuary(data, child, useBanner: false),
    };
  }

  MediaQuery _mediaQuary(
    MediaQueryData data,
    Widget? child, {
    bool useBanner = true,
    // required Flavor flavor,
    // String bannerMessage = "Dev",
    // Color bannerColor = AppColorSwatch.WARNING,
  }) {
    return MediaQuery(
      data: data,
      child: useBanner
          ? Banner(
              message: connection ? FlavorServices.instance.flavor.bannerName : "Offline",
              color: connection ? FlavorServices.instance.flavor.baseColor : AppColorSwatch.DANGER,
              location: BannerLocation.topEnd,
              child: child,
            )
          : child ?? const SizedBox(),
    );
  }
}
