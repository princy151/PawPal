import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawpal/features/auth/presentation/view/registration_view.dart';

void main() {
  testWidgets('Should display two tabs: Pet Owner and Pet Sitter',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationView()));
    expect(find.text('Pet Owner'), findsOneWidget);
    expect(find.text('Pet Sitter'), findsOneWidget);
  });

  testWidgets('Pet Owner tab should display an email field',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationView()));
    expect(find.widgetWithText(TextFormField, "Email"), findsOneWidget);
  });

  testWidgets('Pet Sitter tab should display an email field',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationView()));
    await tester.tap(find.text('Pet Sitter'));
    await tester.pump();
    expect(find.widgetWithText(TextFormField, "Email"), findsOneWidget);
  });

  testWidgets('Pet Owner tab should display a password field',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationView()));
    expect(find.widgetWithText(TextFormField, "Password"), findsOneWidget);
  });

  testWidgets('Pet Sitter tab should display a password field',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationView()));
    await tester.tap(find.text('Pet Sitter'));
    await tester.pump();
    expect(find.widgetWithText(TextFormField, "Password"), findsOneWidget);
  });

  testWidgets('Pet Owner tab should display a phone number field',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationView()));
    expect(find.widgetWithText(TextFormField, "Phone Number"), findsOneWidget);
  });

  testWidgets('Pet Sitter tab should display a phone number field',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationView()));
    await tester.tap(find.text('Pet Sitter'));
    await tester.pump();
    expect(find.widgetWithText(TextFormField, "Phone Number"), findsOneWidget);
  });

  testWidgets('Pet Owner tab should display an address field',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationView()));
    expect(find.widgetWithText(TextFormField, "Address"), findsOneWidget);
  });

  testWidgets('Pet Sitter tab should display an address field',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationView()));
    await tester.tap(find.text('Pet Sitter'));
    await tester.pump();
    expect(find.widgetWithText(TextFormField, "Address"), findsOneWidget);
  });
}
