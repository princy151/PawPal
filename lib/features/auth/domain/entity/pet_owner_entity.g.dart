// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_owner_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetEntity _$PetEntityFromJson(Map<String, dynamic> json) => PetEntity(
      petname: json['petname'] as String,
      type: json['type'] as String,
      petimage: json['petimage'] as String?,
      petinfo: json['petinfo'] as String?,
      openbooking: json['openbooking'] as String? ?? 'no',
      booked: json['booked'] as String? ?? 'no',
    );

Map<String, dynamic> _$PetEntityToJson(PetEntity instance) => <String, dynamic>{
      'petname': instance.petname,
      'type': instance.type,
      'petimage': instance.petimage,
      'petinfo': instance.petinfo,
      'openbooking': instance.openbooking,
      'booked': instance.booked,
    };
