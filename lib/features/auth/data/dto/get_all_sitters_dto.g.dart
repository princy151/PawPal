// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_sitters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllSittersDTO _$GetAllSittersDTOFromJson(Map<String, dynamic> json) =>
    GetAllSittersDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => SitterApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllSittersDTOToJson(GetAllSittersDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
