// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pets_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetApiModel _$PetApiModelFromJson(Map<String, dynamic> json) => PetApiModel(
      petId: json['_id'] as String?,
      petname: json['petname'] as String,
      type: json['type'] as String,
      petimage: json['petimage'] as String?,
      petinfo: json['petinfo'] as String?,
      openbooking: json['openbooking'] as String? ?? 'no',
      booked: json['booked'] as String? ?? 'no',
    );

Map<String, dynamic> _$PetApiModelToJson(PetApiModel instance) =>
    <String, dynamic>{
      '_id': instance.petId,
      'petname': instance.petname,
      'type': instance.type,
      'petimage': instance.petimage,
      'petinfo': instance.petinfo,
      'openbooking': instance.openbooking,
      'booked': instance.booked,
    };
