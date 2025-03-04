// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_owners_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllOwnersDTO _$GetAllOwnersDTOFromJson(Map<String, dynamic> json) =>
    GetAllOwnersDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllOwnersDTOToJson(GetAllOwnersDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
