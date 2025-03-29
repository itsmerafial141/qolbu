import 'package:flutter/material.dart';
import 'package:qolbu/my_app.dart';
import 'package:qolbu/services/flavor_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    FlavorServices.initialize(),
  ]);
  runApp(MyApp());
}
