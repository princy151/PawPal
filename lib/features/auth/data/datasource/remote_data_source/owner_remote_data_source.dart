import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pawpal/app/constants/api_endpoints.dart';
import 'package:pawpal/features/auth/data/datasource/owner_data_source.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

class OwnerRemoteDataSource implements IOwnerDataSource {
  final Dio _dio;
  OwnerRemoteDataSource(this._dio);

  @override
  Future<void> registerOwner(PetOwnerEntity owner) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "name": owner.name,
          "email": owner.email,
          "phone": owner.phone,
          "address": owner.address,
          "image": owner.image,
          "password": owner.password,
          "pets": owner.pets
              .map((pet) => {
                    "petname": pet.petname,
                    "type": pet.type,
                    "petimage": pet.petimage,
                    "petinfo": pet.petinfo,
                    "openbooking": pet.openbooking,
                    "booked": pet.booked,
                  })
              .toList(),
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
  Future<PetOwnerEntity> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<String> loginOwner(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
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
