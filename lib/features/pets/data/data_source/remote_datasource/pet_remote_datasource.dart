import 'package:dio/dio.dart';
import 'package:pawpal/app/constants/api_endpoints.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:pawpal/features/pets/data/data_source/pet_datasource.dart';
import 'package:pawpal/features/pets/data/model/pets_api_model.dart';

class PetRemoteDataSource implements IPetDataSource {
  final Dio _dio;

  PetRemoteDataSource(this._dio);

  @override
  Future<void> createPet(PetEntity pet, String ownerId) async {
    try {
      // Convert entity to model
      var petApiModel = PetApiModel.fromEntity(pet);
      var response = await _dio.post(
        '${ApiEndpoints.createPet}$ownerId',
        data: petApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
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
  Future<void> deletePet(String ownerId, String petId, String? token) async {
    try {
      print('VAL: JSON: DELETE $token');
      var response = await _dio.delete(
        '${ApiEndpoints.deletePet}$ownerId/pets/$petId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
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
