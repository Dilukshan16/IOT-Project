import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waste_management_app/main.dart';

void main() {
  group('Waste Management App Tests', () {
    testWidgets('App loads and shows login screen', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const WasteManagementApp());

      // Verify the app title is shown
      expect(find.text('Waste Management'), findsOneWidget);
      
      // Verify the email/username field appears
      expect(find.text('Email or Username'), findsOneWidget);
      
      // Verify the password field appears
      expect(find.text('Enter password'), findsOneWidget);
      
      // Verify the login button exists
      expect(find.text('LOGIN'), findsOneWidget);
    });

    testWidgets('Login form validation works', (WidgetTester tester) async {
      await tester.pumpWidget(const WasteManagementApp());

      // Try to login without entering credentials
      await tester.tap(find.text('LOGIN'));
      await tester.pump();

      // Verify validation errors appear
      expect(find.text('Please enter your email or username'), findsOneWidget);
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });

    testWidgets('Successful login shows snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(const WasteManagementApp());

      // Enter valid credentials
      await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');
      
      // Tap the login button
      await tester.tap(find.text('LOGIN'));
      await tester.pump();

      // Verify the loading indicator appears
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Wait for the "network request" to complete
      await tester.pump(const Duration(seconds: 2));
      
      // Verify success message appears
      expect(find.text('Login successful!'), findsOneWidget);
    });
  });
}