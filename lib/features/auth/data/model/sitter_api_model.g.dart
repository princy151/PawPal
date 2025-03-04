// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sitter_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SitterApiModel _$SitterApiModelFromJson(Map<String, dynamic> json) =>
    SitterApiModel(
      id: json['_id'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SitterApiModelToJson(SitterApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
      'address': instance.address,
      'password': instance.password,
    };
