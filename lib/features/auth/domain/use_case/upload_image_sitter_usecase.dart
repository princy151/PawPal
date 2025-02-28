import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pawpal/app/usecase/usecase.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/repository/sitter_repository.dart';

class UploadImageSitterParams {
  final File file;

  const UploadImageSitterParams({
    required this.file,
  });
}

class UploadImageSitterUsecase
    implements UsecaseWithParams<String, UploadImageSitterParams> {
  final ISitterRepository _repository;

  UploadImageSitterUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadImageSitterParams params) {
    return _repository.uploadProfilePicture(params.file);
  }
}
