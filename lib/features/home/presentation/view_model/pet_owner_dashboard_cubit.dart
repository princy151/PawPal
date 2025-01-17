import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/features/auth/presentation/view/login_view.dart';
import 'package:pawpal/features/auth/presentation/view_model/owner_login/owner_login_bloc.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_dashboard_state.dart';

class PetOwnerDashboardCubit extends Cubit<PetOwnerDashboardState> {
  PetOwnerDashboardCubit() : super(PetOwnerDashboardState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void logout(BuildContext context) {
    // Wait for 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<OwnerLoginBloc>(),
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }
}
