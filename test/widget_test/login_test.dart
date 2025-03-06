import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawpal/features/auth/presentation/view/login_view.dart';

void main() {
  testWidgets('Finds Pet Owner and Pet Sitter Tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    expect(find.text('Pet Owner'), findsOneWidget);
    expect(find.text('Pet Sitter'), findsOneWidget);
  });

  testWidgets('Finds Email and Password Fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('Finds Login Button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Switches Between Pet Owner and Pet Sitter Tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    // Tap on "Pet Sitter" tab
    await tester.tap(find.text('Pet Sitter'));
    await tester.pump();

    // Check if "Pet Sitter Login" appears
    expect(find.text('Pet Sitter Login'), findsOneWidget);
  });

  testWidgets('Entering Text in Email Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    expect(find.text('test@example.com'), findsOneWidget);
  });

  testWidgets('Entering Text in Password Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    await tester.enterText(find.byType(TextField).last, 'password123');
    expect(find.text('password123'), findsOneWidget);
  });
}
