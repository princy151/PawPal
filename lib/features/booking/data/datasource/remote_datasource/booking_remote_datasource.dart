import 'package:dio/dio.dart';
import 'package:pawpal/app/constants/api_endpoints.dart';
import 'package:pawpal/features/booking/data/datasource/booking_datasource.dart';
import 'package:pawpal/features/booking/data/dto/get_all_bookings_dto.dart';
import 'package:pawpal/features/booking/data/model/booking_api_model.dart';
import 'package:pawpal/features/booking/domain/entity/booking_entity.dart';

class BookingRemoteDataSource implements IBookingDataSource {
  final Dio _dio;

  BookingRemoteDataSource(this._dio);

  @override
  Future<void> createBooking(BookingEntity booking) async {
    try {
      // Convert entity to model
      var bookingApiModel = BookingApiModel.fromEntity(booking);
      var response = await _dio.post(
        ApiEndpoints.createBooking,
        data: bookingApiModel.toJson(),
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
  Future<void> deleteBooking(String id, String? token) async {
    try {
      print('VAL: JSON: DELETE $token');
      var response = await _dio.delete(
        '${ApiEndpoints.deleteBooking}$id',
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

  @override
  Future<List<BookingEntity>> getBookings() async {
    try {
      var response = await _dio.get(
        ApiEndpoints.getAllBookings,
      );
      print('VAL: JSON:1 $response');

      GetAllBookingsDTO bookingDTO = GetAllBookingsDTO.fromJson(response.data);
      var val = BookingApiModel.toEntityList(bookingDTO.data);
      print("VAL: $val");
      return val;
    } on DioException catch (e) {
      throw Exception((e));
    } catch (e) {
      throw Exception(' REMOTE DS ${e.toString()}');
    }
  }
}
