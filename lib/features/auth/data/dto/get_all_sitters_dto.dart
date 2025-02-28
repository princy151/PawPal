import 'package:json_annotation/json_annotation.dart';
import 'package:pawpal/features/auth/data/model/sitter_api_model.dart';

part 'get_all_sitters_dto.g.dart';

@JsonSerializable()
class GetAllSittersDTO {
  final bool success;
  final int count;
  final List<AuthApiModel> data;

  GetAllSittersDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllSittersDTOToJson(this);

  factory GetAllSittersDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllSittersDTOFromJson(json);
}
