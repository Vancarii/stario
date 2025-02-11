// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stario/main.dart';
import 'package:stario/src/shared_prefs/shared_prefs.dart';

void main() {
  setUpAll(() async {
    // Mock SharedPreferences before running tests
    SharedPreferences.setMockInitialValues({
      keyUsername: "TestUser",  
    });

    await SharedPrefs.instance.init(); 
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(StarioApp());
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
