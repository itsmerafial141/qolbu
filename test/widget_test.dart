// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // ignore: unused_element
    Map<int, String> createMaterialColor(Color color) {
      List<double> strengths = <double>[.05, .1, .2, .3, .4, .5, .6, .7, .8, .9];
      Map<int, String> swatch = {};

      for (int i = 0; i < strengths.length; i++) {
        final double strength = strengths[i];
        swatch[(strength * 1000).round()] = "0x${Color.fromRGBO(
          color.red + ((255 - color.red) * strength).round(),
          color.green + ((255 - color.green) * strength).round(),
          color.blue + ((255 - color.blue) * strength).round(),
          1,
        ).value.toRadixString(16).toUpperCase()}";
      }

      // return MaterialColor(color.value, swatch);
      return swatch;
    }
  });
}
