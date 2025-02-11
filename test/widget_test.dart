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

void main() {
  setUpAll(() async {
    // Mock SharedPreferences before running tests
    SharedPreferences.setMockInitialValues({
      "key_username": "TestUser",  // Add a mock value to avoid null errors
    });
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Ensure SharedPreferences is initialized before running the app
    await SharedPreferences.getInstance();

    // Build our app and trigger a frame
    await tester.pumpWidget(StarioApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
