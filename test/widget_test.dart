// Test file for Grid Background Generator app

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:background_generator/main.dart';
import '../lib/utils/app_constants.dart';

void main() {
  testWidgets('App launches with grid background screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BackgroundGeneratorApp());

    // Verify that the refresh button is present
    expect(find.byIcon(Icons.refresh), findsOneWidget);

    // Verify that we have two FloatingActionButtons (settings and refresh)
    expect(find.byType(FloatingActionButton), findsNWidgets(AppConstants.expectedFloatingActionButtonCount));
  });

  testWidgets('Refresh button regenerates pattern', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const BackgroundGeneratorApp());

    // Tap the refresh button
    await tester.tap(find.byIcon(Icons.refresh));
    
    // Wait a bit for the button state to change
    await tester.pump(AppConstants.testPumpDuration);

    // Verify that the refresh button is now showing loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    // Verify that the app is still running (no errors)
    expect(find.byType(FloatingActionButton), findsNWidgets(AppConstants.expectedFloatingActionButtonCount));
  });
}