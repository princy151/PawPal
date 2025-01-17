import 'package:get_it/get_it.dart';
import 'package:pawpal/core/network/hive_service.dart';
import 'package:pawpal/features/auth/data/datasource/local_data_source/owner_local_data_source.dart';
import 'package:pawpal/features/auth/data/repository/owner_local_repository.dart';
import 'package:pawpal/features/auth/domain/use_case/owner_login_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/owner_register_usecase.dart';
import 'package:pawpal/features/auth/presentation/view_model/owner_login/owner_login_bloc.dart';
import 'package:pawpal/features/auth/presentation/view_model/owner_signup/owner_signup_bloc.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_dashboard_cubit.dart';
import 'package:pawpal/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => OwnerLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => OwnerLocalRepository(getIt<OwnerLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<OwnerRegisterUsecase>(
    () => OwnerRegisterUsecase(
      getIt<OwnerLocalRepository>(),
    ),
  );

  getIt.registerFactory<OwnerSignupBloc>(
    () => OwnerSignupBloc(
      ownerRegisterUsecase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<PetOwnerDashboardCubit>(
    () => PetOwnerDashboardCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<OwnerLoginUseCase>(
    () => OwnerLoginUseCase(
      getIt<OwnerLocalRepository>(),
    ),
  );

  getIt.registerFactory<OwnerLoginBloc>(
    () => OwnerLoginBloc(
      ownerRegisterBloc: getIt<OwnerSignupBloc>(),
      petOwnerDashboardCubit: getIt<PetOwnerDashboardCubit>(),
      ownerLoginUseCase: getIt<OwnerLoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OwnerLoginBloc>()),
  );
}
