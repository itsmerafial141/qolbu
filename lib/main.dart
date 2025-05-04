import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qolbu/my_app.dart';
import 'package:qolbu/services/dialog_service.dart';
import 'package:qolbu/services/dio/dio_service.dart';
import 'package:qolbu/services/flavor_service.dart';
import 'package:qolbu/services/hive_service.dart';
import 'package:qolbu/services/permission_service.dart';
import 'package:qolbu/services/version_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    SentryFlutter.init(
      (options) {
        options.dsn = dotenv.env['SENTRY_DSN'];
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
        // The sampling rate for profiling is relative to tracesSampleRate
        // Setting to 1.0 will profile 100% of sampled transactions:
        options.profilesSampleRate = 1.0;
        options.environment = FlavorServices.instance.flavor.name;
      },
      appRunner: () {
        Future.wait([
          FlavorServices.initialize(),
          DialogService.initialize(),
          DioService.initialize(),
          PermissionService.initialize(),
          VersionService.initialize(),
          HiveService.initialize(),
        ]).then((_) => runApp(SentryWidget(child: MyApp())));
      },
    );
  } catch (e) {
    Sentry.captureException(e);
  }
}
