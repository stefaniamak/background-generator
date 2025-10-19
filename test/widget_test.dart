// Test file for Grid Background Generator app

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:background_generator/main.dart';

void main() {
  testWidgets('App launches with grid background screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BackgroundGeneratorApp());

    // Verify that the refresh button is present
    expect(find.byIcon(Icons.refresh), findsOneWidget);

    // Verify that we have a FloatingActionButton
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Refresh button regenerates pattern', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const BackgroundGeneratorApp());

    // Tap the refresh button
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pumpAndSettle();

    // Verify that the app is still running (no errors)
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}