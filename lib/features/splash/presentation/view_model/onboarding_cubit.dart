import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/features/auth/presentation/view/login_view.dart';
import 'package:pawpal/features/auth/presentation/view_model/owner_login/owner_login_bloc.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_dashboard_state.dart';

class OnboardingCubit extends Cubit<PetOwnerDashboardState> {
  OnboardingCubit() : super(PetOwnerDashboardState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void goToLogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 0), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<OwnerLoginBloc>(),
              child: const LoginView(),
            ),
          ),
        );
      }
    });
  }
}
