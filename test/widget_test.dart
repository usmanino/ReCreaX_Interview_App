// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recrex_interview/main.dart';
import 'package:recrex_interview/core/di/service_locator.dart';

void main() {
  setUp(() async {
    // Reset GetIt instance before each test
    await sl.reset();
    // Setup the service locator for each test
    await setupServiceLocator();
  });

  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the app loads with Articles Reader title
    expect(find.text('Articles Reader'), findsOneWidget);

    // Verify that we can find the search bar
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Search bar is present', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify search bar exists
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search articles by title...'), findsOneWidget);
  });
}
