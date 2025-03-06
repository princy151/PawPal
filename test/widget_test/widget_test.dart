import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawpal/features/splash/presentation/view/onboarding_view.dart';
import 'package:pawpal/features/splash/presentation/view_model/onboarding_cubit.dart';

void main() {
  testWidgets('Onboarding screen displays first page correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<OnboardingCubit>(
          create: (_) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    );

    expect(find.text('Welcome to PawPal'), findsOneWidget);
  });

  testWidgets('Pressing next button moves to second page',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<OnboardingCubit>(
          create: (_) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();

    expect(find.text('Track Your Pets'), findsOneWidget);
  });

  testWidgets('Pressing next multiple times reaches last page',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<OnboardingCubit>(
          create: (_) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();

    expect(find.text('Stay Connected'), findsOneWidget);
  });

  testWidgets('Skip button skips to login', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<OnboardingCubit>(
          create: (_) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsNothing);
  });

  testWidgets('Page indicators update on navigation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<OnboardingCubit>(
          create: (_) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    );

    final initialIndicator = find.descendant(
      of: find.byType(Row),
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is CircleAvatar &&
            widget.backgroundColor == const Color(0xFFB55C50),
      ),
    );

    expect(initialIndicator, findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();

    final updatedIndicator = find.descendant(
      of: find.byType(Row),
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is CircleAvatar &&
            widget.backgroundColor == const Color(0xFFB55C50),
      ),
    );

    expect(updatedIndicator, findsOneWidget);
  });

  testWidgets('Last page shows check icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<OnboardingCubit>(
          create: (_) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.check), findsOneWidget);
  });
}
