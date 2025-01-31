import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/repository/owner_repository.dart';

class OwnerLoginParams extends Equatable {
  final String username;
  final String password;

  const OwnerLoginParams({
    required this.username,
    required this.password,
  });

  // Initial Constructor
  const OwnerLoginParams.initial()
      : username = '',
        password = '';

  @override
  List<Object> get props => [username, password];
}

class OwnerLoginUseCase implements UsecaseWithParams<String, OwnerLoginParams> {
  final IOwnerRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  OwnerLoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(OwnerLoginParams params) {
    // Save token in Shared Preferences
    return repository
        .loginOwner(params.username, params.password)
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
