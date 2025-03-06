import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/core/network/api_service.dart';
import 'package:pawpal/features/auth/data/datasource/remote_data_source/owner_remote_data_source.dart';
import 'package:pawpal/features/auth/data/datasource/remote_data_source/sitter_remote_data_source.dart';
import 'package:pawpal/features/auth/data/repository/owner_remote_repository.dart';
import 'package:pawpal/features/auth/data/repository/sitter_remote_repository.dart';
import 'package:pawpal/features/auth/domain/use_case/get_all_owners_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/get_all_sitters_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/get_owner_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/get_sitter_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/owner_login_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/owner_register_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/owner_update_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/sitter_login_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/sitter_register_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/sitter_update_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/upload_image_sitter_usecase.dart';
import 'package:pawpal/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:pawpal/features/auth/presentation/view_model/login/owner_login_bloc.dart';
import 'package:pawpal/features/auth/presentation/view_model/login/sitter_login_bloc.dart';
import 'package:pawpal/features/auth/presentation/view_model/profile/owner_profile_bloc.dart';
import 'package:pawpal/features/auth/presentation/view_model/profile/sitter_profile_bloc.dart';
import 'package:pawpal/features/auth/presentation/view_model/signup/owner_signup_bloc.dart';
import 'package:pawpal/features/auth/presentation/view_model/signup/sitter_signup_bloc.dart';
import 'package:pawpal/features/booking/data/datasource/remote_datasource/booking_remote_datasource.dart';
import 'package:pawpal/features/booking/data/repository/booking_remote_repository.dart';
import 'package:pawpal/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:pawpal/features/booking/domain/use_case/delete_booking_usecase.dart';
import 'package:pawpal/features/booking/domain/use_case/get_all_bookings_usecase.dart';
import 'package:pawpal/features/booking/presentation/view_model/bookings_bloc.dart';
import 'package:pawpal/features/dashboard/presentation/view_model/owner_dashboard_bloc.dart';
import 'package:pawpal/features/dashboard/presentation/view_model/sitter_dashboard_bloc.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_owner_home_cubit.dart';
import 'package:pawpal/features/home/presentation/view_model/pet_sitter_home_cubit.dart';
import 'package:pawpal/features/pets/domain/use_case/create_pet_usecase.dart';
import 'package:pawpal/features/pets/domain/use_case/delete_pet_usecase.dart';
import 'package:pawpal/features/pets/presentation/view_model/pet_bloc.dart';
import 'package:pawpal/features/splash/presentation/view_model/onboarding_cubit.dart';
import 'package:pawpal/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initOnboardingScreenDependencies();
  await _initSplashScreenDependencies();
  await _initSitterDependencies();
  await _initSitterHomeDependencies();
  await _initSitterProfileDependencies();
  await _initOwnerProfileDependencies();
  await _initBookingDependencies();
  await _initPetsDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initHiveService() {
  // getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // init Api
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initRegisterDependencies() {
  // init local data source
  // getIt.registerLazySingleton(
  //   () => OwnerLocalDataSource(getIt<HiveService>()),
  // );

  //  Remote Data Source owner
  getIt.registerFactory<OwnerRemoteDataSource>(
    () => OwnerRemoteDataSource(
      getIt<Dio>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  // getIt.registerFactory<SitterRemoteDataSource>(
  //   () => SitterRemoteDataSource(getIt<Dio>()),
  // );

  // init local repository
  // getIt.registerLazySingleton(
  //   () => OwnerLocalRepository(getIt<OwnerLocalDataSource>()),
  // );

  // remote Repository register
  getIt.registerLazySingleton<OwnerRemoteRepository>(
    () => OwnerRemoteRepository(getIt<OwnerRemoteDataSource>()),
  );

  getIt.registerLazySingleton<SitterRemoteRepository>(
    () => SitterRemoteRepository(getIt<SitterRemoteDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<OwnerRegisterUsecase>(
    () => OwnerRegisterUsecase(
      getIt<OwnerRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<SitterRegisterUsecase>(
    () => SitterRegisterUsecase(
      getIt<SitterRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<OwnerRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageSitterUsecase>(
    () => UploadImageSitterUsecase(
      getIt<SitterRemoteRepository>(),
    ),
  );

  getIt.registerFactory<OwnerSignupBloc>(
    () => OwnerSignupBloc(
      ownerRegisterUsecase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );

  getIt.registerFactory<SitterSignupBloc>(
    () => SitterSignupBloc(
      sitterRegisterUsecase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<OwnerHomeCubit>(
    () => OwnerHomeCubit(),
  );
}

_initSitterHomeDependencies() async {
  getIt.registerFactory<SitterHomeCubit>(
    () => SitterHomeCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<OwnerLoginUseCase>(
    () => OwnerLoginUseCase(
      getIt<OwnerRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerLazySingleton<SitterLoginUseCase>(
    () => SitterLoginUseCase(
      getIt<SitterRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<OwnerLoginBloc>(
    () => OwnerLoginBloc(
      ownerRegisterBloc: getIt<OwnerSignupBloc>(),
      sitterRegisterBloc: getIt<SitterSignupBloc>(),
      petOwnerDashboardCubit: getIt<OwnerHomeCubit>(),
      ownerLoginUseCase: getIt<OwnerLoginUseCase>(),
      sitterHomeCubit: getIt<SitterHomeCubit>(),
    ),
  );

  getIt.registerFactory<SitterLoginBloc>(
    () => SitterLoginBloc(
      ownerRegisterBloc: getIt<OwnerSignupBloc>(),
      sitterRegisterBloc: getIt<SitterSignupBloc>(),
      petOwnerDashboardCubit: getIt<OwnerHomeCubit>(),
      sitterLoginUseCase: getIt<SitterLoginUseCase>(),
      sitterHomeCubit: getIt<SitterHomeCubit>(),
    ),
  );
}

_initSitterDependencies() async {
  // =========================== Data Source ===========================
  // getIt.registerFactory<BatchLocalDataSource>(
  //     () => BatchLocalDataSource(hiveService: getIt<HiveService>()));

  getIt.registerLazySingleton<SitterRemoteDataSource>(
    () => SitterRemoteDataSource(
      getIt<Dio>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  // =========================== Repository ===========================

  // getIt.registerLazySingleton<ItemLocalRepository>(() => BatchLocalRepository(
  //     batchLocalDataSource: getIt<BatchLocalDataSource>()));

  // getIt.registerLazySingleton(() => SitterRemoteRepository(
  //       getIt<SitterRemoteDataSource>(), // ✅ Correct
  //     ));

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<GetAllSitterUseCase>(
    () =>
        GetAllSitterUseCase(sitterRepository: getIt<SitterRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetAllOwnerUseCase>(
    () => GetAllOwnerUseCase(ownerRepository: getIt<OwnerRemoteRepository>()),
  );

  // =========================== Bloc ===========================
  getIt.registerFactory<OwnerDashboardBloc>(
    () => OwnerDashboardBloc(
      getAllSitterUseCase: getIt<GetAllSitterUseCase>(),
    ),
  );

  getIt.registerFactory<SitterDashboardBloc>(
    () => SitterDashboardBloc(
      getAllOwnerUseCase: getIt<GetAllOwnerUseCase>(),
      createBookingUseCase: getIt<CreateBookingUseCase>(),
      bookingsBloc: getIt<BookingsBloc>(),
    ),
  );
}

_initSitterProfileDependencies() async {
  getIt.registerLazySingleton<GetSitterUsecase>(
    () => GetSitterUsecase(
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerLazySingleton<UpdateSitterUsecase>(
    () => UpdateSitterUsecase(
      getIt<SitterRemoteRepository>(),
    ),
  );

  getIt.registerFactory<SitterProfileBloc>(
    () => SitterProfileBloc(
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
        updateSitterUsecase: getIt<UpdateSitterUsecase>(),
        getSitterUsecase: getIt<GetSitterUsecase>()),
  );
}

_initOwnerProfileDependencies() async {
  getIt.registerLazySingleton<GetOwnerUsecase>(
    () => GetOwnerUsecase(
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerLazySingleton<UpdateOwnerUsecase>(
    () => UpdateOwnerUsecase(
      getIt<OwnerRemoteRepository>(),
    ),
  );

  getIt.registerFactory<OwnerProfileBloc>(
    () => OwnerProfileBloc(
        tokenSharedPrefs: getIt<TokenSharedPrefs>(),
        updateOwnerUsecase: getIt<UpdateOwnerUsecase>(),
        getOwnerUsecase: getIt<GetOwnerUsecase>()),
  );
}

_initBookingDependencies() async {
  // =========================== Data Source ===========================
  // getIt.registerFactory<BatchLocalDataSource>(
  //     () => BatchLocalDataSource(hiveService: getIt<HiveService>()));

  getIt.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSource(
      getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================

  // getIt.registerLazySingleton<ItemLocalRepository>(() => BatchLocalRepository(
  //     batchLocalDataSource: getIt<BatchLocalDataSource>()));

  getIt.registerLazySingleton(
    () => BookingRemoteRepository(
      remoteDataSource: getIt<BookingRemoteDataSource>(),
    ),
  );

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<CreateBookingUseCase>(
    () => CreateBookingUseCase(
        bookingRepository: getIt<BookingRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetAllBookingsUseCase>(
    () => GetAllBookingsUseCase(
        bookingRepository: getIt<BookingRemoteRepository>()),
  );

  getIt.registerLazySingleton<DeleteBookingUsecase>(
    () => DeleteBookingUsecase(
      bookingRepository: getIt<BookingRemoteRepository>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  // =========================== Bloc ===========================
  getIt.registerFactory<BookingsBloc>(
    () => BookingsBloc(
      createBookingUseCase: getIt<CreateBookingUseCase>(),
      getAllBookingsUseCase: getIt<GetAllBookingsUseCase>(),
      deleteBookingUsecase: getIt<DeleteBookingUsecase>(),
    ),
  );
}

_initPetsDependencies() async {
  // =========================== Bloc ===========================
  getIt.registerFactory<PetBloc>(
    () => PetBloc(
      getAllOwnerUseCase: getIt<GetAllOwnerUseCase>(),
      createPetUseCase: getIt<CreatePetUseCase>(),
      deletePetUsecase: getIt<DeletePetUsecase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardingCubit>()),
  );
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(),
  );
}
