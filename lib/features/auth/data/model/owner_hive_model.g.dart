// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OwnerHiveModelAdapter extends TypeAdapter<OwnerHiveModel> {
  @override
  final int typeId = 0;

  @override
  OwnerHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OwnerHiveModel(
      ownerId: fields[0] as String?,
      name: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as String,
      petname: fields[4] as String,
      type: fields[5] as String,
      address: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OwnerHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.ownerId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.petname)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnerHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
