import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/auth/presentation/view/login_view.dart';
import 'package:pawpal/features/auth/presentation/view_model/owner_login/owner_login_bloc.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(this._ownerLoginBloc) : super(null);

  final OwnerLoginBloc _ownerLoginBloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      // Open Login page or Onboarding Screen

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _ownerLoginBloc,
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }
}
