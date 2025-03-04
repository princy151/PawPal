import 'package:json_annotation/json_annotation.dart';
import 'package:pawpal/features/booking/data/model/booking_api_model.dart';

part 'get_all_bookings_dto.g.dart';

@JsonSerializable()
class GetAllBookingsDTO {
  // final bool success;
  // final int count;
  @JsonKey(name: 'bookings')
  final List<BookingApiModel> data;

  GetAllBookingsDTO({
    // required this.success,
    // required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllBookingsDTOToJson(this);

  // factory GetAllBookingsDTO.fromJson(Map<String, dynamic> json) {
  //   print('VAL: JSON: $json');
  //   var val = _$GetAllBookingsDTOFromJson(json);
  //   print('VAL: JSON: CC $val');
  //   return val;
  // }
  factory GetAllBookingsDTO.fromJson(List<dynamic> jsonList) {
    print('VAL: JSON: $jsonList');
    var bookings =
        jsonList.map((json) => BookingApiModel.fromJson(json)).toList();
    print('VAL: JSON: CC $bookings');
    return GetAllBookingsDTO(data: bookings);
  }
}
