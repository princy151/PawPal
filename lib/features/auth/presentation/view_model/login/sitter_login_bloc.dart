import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/core/common/my_snackbar.dart';
import 'package:pawpal/features/auth/domain/use_case/sitter_login_usecase.dart';
import 'package:pawpal/features/auth/presentation/view_model/signup/owner_signup_bloc.dart';
import 'package:pawpal/features/auth/presentation/view_model/signup/sitter_signup_bloc.dart';
import 'package:pawpal/features/home/presentation/view/sitter_home.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_home_cubit.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_sitter_home_cubit.dart';

part 'sitter_login_event.dart';
part 'sitter_login_state.dart';

class SitterLoginBloc extends Bloc<LoginEvent, LoginState> {
  final OwnerSignupBloc _ownerRegisterBloc;
  final SitterHomeCubit _sitterHomeCubit;
  final SitterSignupBloc _sitterRegisterBloc;
  final SitterLoginUseCase _loginUseCase;

  SitterLoginBloc({
    required OwnerSignupBloc ownerRegisterBloc,
    required SitterSignupBloc sitterRegisterBloc,
    required OwnerHomeCubit petOwnerDashboardCubit,
    required SitterLoginUseCase sitterLoginUseCase,
    required SitterHomeCubit sitterHomeCubit,
  })  : _ownerRegisterBloc = ownerRegisterBloc,
        _sitterRegisterBloc = sitterRegisterBloc,
        _loginUseCase = sitterLoginUseCase,
        _sitterHomeCubit = sitterHomeCubit,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _ownerRegisterBloc),
                BlocProvider.value(value: _sitterRegisterBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<NavigateSitterHomeScreenEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _sitterHomeCubit,
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<LoginSitterEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _loginUseCase(
          SitterLoginParams(
            username: event.username,
            password: event.password,
          ),
        );

        result.fold(
          (failure) {
            print('RESULTTT $result');
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: "Invalid Credentials",
              color: Colors.red,
            );
          },
          (token) {
            print('RESULTTT $result');
            emit(state.copyWith(isLoading: false, isSuccess: true));
            add(
              NavigateSitterHomeScreenEvent(
                context: event.context,
                destination: SitterHomeView(),
              ),
            );
            //_homeCubit.setToken(token);
          },
        );
      },
    );
  }
}
