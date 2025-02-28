import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pawpal/app/constants/api_endpoints.dart';
import 'package:pawpal/features/auth/data/datasource/sitter_data_source.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';

class SitterRemoteDataSource implements ISitterDataSource {
  final Dio _dio;
  SitterRemoteDataSource(this._dio);

  @override
  Future<void> registerSitter(PetSitterEntity sitter) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.sitterregister,
        data: {
          "name": sitter.name,
          "email": sitter.email,
          "phone": sitter.phone,
          "address": sitter.address,
          "image": sitter.image,
          "password": sitter.password,
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Server error: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.response?.data ?? e.message}');
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      print('General error: $e');
      throw Exception('General error: $e');
    }
  }

  @override
  Future<PetSitterEntity> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<String> loginSitter(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.sitterlogin,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );
      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
