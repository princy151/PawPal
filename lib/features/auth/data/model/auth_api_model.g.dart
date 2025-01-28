// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      petname: json['petname'] as String,
      type: json['type'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'petname': instance.petname,
      'type': instance.type,
      'image': instance.image,
      'address': instance.address,
    };
