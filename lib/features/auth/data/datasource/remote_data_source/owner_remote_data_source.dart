import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pawpal/app/constants/api_endpoints.dart';
import 'package:pawpal/app/shared_prefs/token_shared_prefs.dart';
import 'package:pawpal/features/auth/data/datasource/owner_data_source.dart';
import 'package:pawpal/features/auth/data/dto/get_all_owners_dto.dart';
import 'package:pawpal/features/auth/data/model/auth_api_model.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

class OwnerRemoteDataSource implements IOwnerDataSource {
  final Dio _dio;
  final TokenSharedPrefs userIdSharedPrefs;
  OwnerRemoteDataSource(this._dio, this.userIdSharedPrefs);

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
  Future<PetOwnerEntity> getCurrentOwner(String? token, String userId) async {
    try {
      Response response = await _dio.get(
        '${ApiEndpoints.getOwner}/$userId',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        print("DATA::: $data");
        if (data == null) {
          throw Exception("User not found");
        }
        return PetOwnerEntity(
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
  Future<String> loginOwner(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      print('Response:: ${response.data}');
      if (response.statusCode == 200) {
        userIdSharedPrefs.setOwner(response.data['userId']);
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
  Future<List<PetOwnerEntity>> getOwners() async {
    try {
      var response = await _dio.get(
        ApiEndpoints.getAllOwners,
      );

      GetAllOwnersDTO ownerDTO = GetAllOwnersDTO.fromJson(response.data);
      print('OWNERS RETRIEVED');
      return AuthApiModel.toEntityList(ownerDTO.data);
    } on DioException catch (e) {
      throw Exception((e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PetOwnerEntity> updateOwner(PetOwnerEntity updateOwner) async {
    try {
      // First, get the current user data from SharedPreferences
      var currentOwner = await userIdSharedPrefs.getOwner();
      // Map<String, dynamic>? currentUser =
      print("Current user before update: $currentOwner");

      // Prepare updated data by merging the current user data and the new data
      try {
        currentOwner?['name'] = updateOwner.name;
        currentOwner?['email'] = updateOwner.email;
        currentOwner?['phone'] = updateOwner.phone;
        currentOwner?['address'] = updateOwner.address;
        currentOwner?['image'] = updateOwner.image;
        print("Current user before update2: $currentOwner");
      } catch (e) {
        print('Error $e');
      }
      var id = currentOwner?['_id'];
      if (updateOwner.image != null) {
        currentOwner?['image'] =
            await MultipartFile.fromFile(updateOwner.image!);
      } else {
        currentOwner!.remove('image');
      }

      print("abc::: $currentOwner");

      currentOwner?.remove('__v');
      var url = ApiEndpoints.updateOwner + id;
      print("URL::: $url");
      // Send the update request to the backend API
      Response response = await _dio.put(
        ApiEndpoints.updateOwner + id,
        data: currentOwner,
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
        Map<String, dynamic> newOwnerData = response.data['data'];
        await userIdSharedPrefs.updateOwner(
          newOwnerData,
        ); // Save updated user data in SharedPreferences

        print("Updated user data saved in SharedPreferences: $newOwnerData");

        // Return the updated user entity
        return PetOwnerEntity.fromJson(newOwnerData);
      } else {
        print("No Data updated $currentOwner");
        throw Exception('Failed to update user: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }
}
