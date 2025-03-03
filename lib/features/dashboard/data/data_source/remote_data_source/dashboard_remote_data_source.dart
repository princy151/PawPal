// import 'package:dio/dio.dart';
// import 'package:infinistone/app/constants/api_endpoints.dart';
// import 'package:infinistone/features/shop/data/data_source/item_data_source.dart';
// import 'package:infinistone/features/shop/data/dto/get_all_item_dto.dart';
// import 'package:infinistone/features/shop/data/model/item_api_model.dart';
// import 'package:infinistone/features/shop/domain/entity/item_entity.dart';

// class ItemRemoteDataSource implements IItemDataSource {
//   final Dio _dio;

//   ItemRemoteDataSource(this._dio);

//   @override
//   Future<void> createItem(ItemEntity item) async {
//     try {
//       // Convert entity to model
//       var itemApiModel = ItemApiModel.fromEntity(item);
//       var response = await _dio.post(
//         ApiEndpoints.createItem,
//         data: itemApiModel.toJson(),
//       );
//       if (response.statusCode == 201) {
//         return;
//       } else {
//         throw Exception(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw Exception(e);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   Future<void> deleteItem(String id, String? token) async {
//     try {
//       var response = await _dio.delete(
//         ApiEndpoints.deleteItem + id,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         return;
//       } else {
//         throw Exception(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw Exception(e);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   Future<List<ItemEntity>> getItems() async {
//     try {
//       var response = await _dio.get(
//         ApiEndpoints.getAllItems,
//       );

//       GetAllItemDTO itemDTO = GetAllItemDTO.fromJson(response.data);
//       return ItemApiModel.toEntityList(itemDTO.data);
//     } on DioException catch (e) {
//       throw Exception((e));
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
