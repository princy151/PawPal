import 'package:json_annotation/json_annotation.dart';
import 'package:pawpal/features/auth/data/model/auth_api_model.dart';

part 'get_all_owners_dto.g.dart';

@JsonSerializable()
class GetAllOwnersDTO {
  // final bool success;
  // final int count;
  final List<AuthApiModel> data;

  GetAllOwnersDTO({
    // required this.success,
    // required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllOwnersDTOToJson(this);

  factory GetAllOwnersDTO.fromJson(Map<String, dynamic> json) {
    print('OWNERS RETRIEVED ${json.runtimeType}');
    try {
      return _$GetAllOwnersDTOFromJson(json);
    } catch (e) {
      print('OWNERS RETRIEVED EXCEPTION $e');
      return _$GetAllOwnersDTOFromJson(json);
    }
  }
}
