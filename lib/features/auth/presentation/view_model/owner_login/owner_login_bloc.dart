import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/core/common/my_snackbar.dart';
import 'package:pawpal/features/auth/domain/use_case/owner_login_usecase.dart';
import 'package:pawpal/features/auth/presentation/view_model/owner_signup/owner_signup_bloc.dart';
import 'package:pawpal/features/home/presentation/view/pet_owner_dashboard_view.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_dashboard_cubit.dart';

part 'owner_login_event.dart';
part 'owner_login_state.dart';

class OwnerLoginBloc extends Bloc<LoginEvent, LoginState> {
  final OwnerSignupBloc _ownerRegisterBloc;
  final PetOwnerDashboardCubit _petOwnerDashboardCubit;
  final OwnerLoginUseCase _loginUseCase;

  OwnerLoginBloc({
    required OwnerSignupBloc ownerRegisterBloc,
    required PetOwnerDashboardCubit petOwnerDashboardCubit,
    required OwnerLoginUseCase ownerLoginUseCase,
  })  : _ownerRegisterBloc = ownerRegisterBloc,
        _petOwnerDashboardCubit = petOwnerDashboardCubit,
        _loginUseCase = ownerLoginUseCase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _ownerRegisterBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<NavigateHomeScreenEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _petOwnerDashboardCubit,
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<LoginOwnerEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _loginUseCase(
          OwnerLoginParams(
            username: event.username,
            password: event.password,
          ),
        );

        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: "Invalid Credentials",
              color: Colors.red,
            );
          },
          (token) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            add(
              NavigateHomeScreenEvent(
                context: event.context,
                destination: PetOwnerDashboardView(),
              ),
            );
            //_homeCubit.setToken(token);
          },
        );
      },
    );
  }
}
