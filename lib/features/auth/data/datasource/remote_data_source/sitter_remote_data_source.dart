import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pawpal/app/constants/api_endpoints.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/features/auth/data/datasource/sitter_data_source.dart';
import 'package:pawpal/features/auth/data/dto/get_all_sitters_dto.dart';
import 'package:pawpal/features/auth/data/model/sitter_api_model.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';

class SitterRemoteDataSource implements ISitterDataSource {
  final Dio _dio;
  final TokenSharedPrefs userIdSharedPrefs;
  SitterRemoteDataSource(this._dio, this.userIdSharedPrefs);

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
  Future<PetSitterEntity> getCurrentSitter(String? token, String userId) async {
    try {
      Response response = await _dio.get(
        '${ApiEndpoints.getSitter}/$userId',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        print("DATA::: $data");
        if (data == null) {
          throw Exception("User not found");
        }
        return PetSitterEntity(
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          email: data['email'] ?? '',
          phone: data['phone'] ?? '',
          address: data['address'] ?? '',
          password: '',
        );
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'An error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
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
      print('RESULTTT $response');
      if (response.statusCode == 200) {
        print('RESULTTTTTT');
        userIdSharedPrefs.setOwner(response.data['sitter']);
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

  @override
  Future<List<PetSitterEntity>> getSitters() async {
    try {
      var response = await _dio.get(
        ApiEndpoints.getAllSitters,
      );

      GetAllSittersDTO sitterDTO = GetAllSittersDTO.fromJson(response.data);
      return SitterApiModel.toEntityList(sitterDTO.data);
    } on DioException catch (e) {
      throw Exception((e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PetSitterEntity> updateSitter(PetSitterEntity updatedOwner) async {
    try {
      // First, get the current user data from SharedPreferences
      var currentSitter = await userIdSharedPrefs.getSitter();
      // Map<String, dynamic>? currentUser =
      print("Current sitter before update: $currentSitter");

      // Prepare updated data by merging the current user data and the new data
      try {
        currentSitter?['name'] = updatedOwner.name;
        currentSitter?['email'] = updatedOwner.email;
        currentSitter?['phone'] = updatedOwner.phone;
        currentSitter?['address'] = updatedOwner.address;
        currentSitter?['image'] = updatedOwner.image;
      } catch (e) {
        print('Error $e');
      }
      var id = currentSitter?['_id'];
      if (updatedOwner.image != null) {
        currentSitter?['image'] =
            await MultipartFile.fromFile(updatedOwner.image!);
      } else {
        currentSitter!.remove('image');
      }

      print("abc::: $currentSitter");

      currentSitter?.remove('__v');
      var url = ApiEndpoints.updateOwner + id;
      print("URL::: $url");
      // Send the update request to the backend API
      Response response = await _dio.put(
        ApiEndpoints.updateOwner + id,
        data: currentSitter,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      print("API Endpoint: $response");

      if (response.statusCode == 200) {
        // On success, update the local SharedPreferences with the new user data
        Map<String, dynamic> newSitterData = response.data['data'];
        await userIdSharedPrefs.updateSitter(
          newSitterData,
        ); // Save updated user data in SharedPreferences

        print("Updated user data saved in SharedPreferences: $newSitterData");

        // Return the updated user entity
        return PetOwnerEntity.fromJson(newSitterData);
      } else {
        print("No Data updated $currentSitter");
        throw Exception('Failed to update user: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }
}
