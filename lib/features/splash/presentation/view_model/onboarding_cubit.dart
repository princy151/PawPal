import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/features/auth/presentation/view/login_view.dart';
import 'package:pawpal/features/auth/presentation/view_model/login/owner_login_bloc.dart';
import 'package:pawpal/features/auth/presentation/view_model/login/sitter_login_bloc.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_home_state.dart';

class OnboardingCubit extends Cubit<OwnerHomeState> {
  OnboardingCubit() : super(OwnerHomeState.initial());

  void goToLogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 0), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<OwnerLoginBloc>()),
                BlocProvider.value(value: getIt<SitterLoginBloc>()),
              ],
              child: const LoginView(),
            ),
          ),
        );
      }
    });
  }
}
