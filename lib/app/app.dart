import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/core/theme/app_theme.dart';
import 'package:pawpal/features/splash/presentation/view/splash_screen.dart';
import 'package:pawpal/features/splash/presentation/view_model/splash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PawPal',
      theme: getApplicationTheme(),
      home: BlocProvider.value(
        value: getIt<SplashCubit>(),
        child: SplashView(),
      ),
    );
  }
}
