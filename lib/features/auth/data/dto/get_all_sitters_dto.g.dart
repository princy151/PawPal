// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_sitters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllSittersDTO _$GetAllSittersDTOFromJson(Map<String, dynamic> json) =>
    GetAllSittersDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllSittersDTOToJson(GetAllSittersDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
