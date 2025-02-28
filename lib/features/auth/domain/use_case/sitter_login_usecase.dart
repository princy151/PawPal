import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/repository/sitter_repository.dart';

class SitterLoginParams extends Equatable {
  final String username;
  final String password;

  const SitterLoginParams({
    required this.username,
    required this.password,
  });

  // Initial Constructor
  const SitterLoginParams.initial()
      : username = '',
        password = '';

  @override
  List<Object> get props => [username, password];
}

class SitterLoginUseCase implements UsecaseWithParams<String, SitterLoginParams> {
  final ISitterRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  SitterLoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(SitterLoginParams params) {
    // Save token in Shared Preferences
    return repository
        .loginSitter(params.username, params.password)
        .then((value) {
      return value.fold(
        (failure) => Left(failure),
        (token) {
          tokenSharedPrefs.saveToken(token);
          tokenSharedPrefs.getToken().then((value) {
            print(value);
          });
          return Right(token);
        },
      );
    });
  }
}
