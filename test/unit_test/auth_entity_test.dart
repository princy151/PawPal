import 'package:flutter_test/flutter_test.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

void main() {
  test('1. PetEntity should be instantiated correctly', () {
    final pet = PetEntity(
      petId: '123',
      petname: 'Fluffy',
      type: 'Dog',
      petimage: 'image_url',
      petinfo: 'Fluffy is a friendly dog',
      openbooking: 'yes',
      booked: 'no',
    );

    expect(pet.petId, '123');
    expect(pet.petname, 'Fluffy');
    expect(pet.type, 'Dog');
    expect(pet.petimage, 'image_url');
    expect(pet.petinfo, 'Fluffy is a friendly dog');
    expect(pet.openbooking, 'yes');
    expect(pet.booked, 'no');
  });

  test('2. PetEntity should correctly convert from JSON', () {
    final petJson = {
      '_id': '123',
      'petname': 'Fluffy',
      'type': 'Dog',
      'petimage': 'image_url',
      'petinfo': 'Friendly dog',
      'openbooking': 'yes',
      'booked': 'no'
    };

    final pet = PetEntity.fromJson(petJson);

    expect(pet.petId, '123');
    expect(pet.petname, 'Fluffy');
    expect(pet.type, 'Dog');
    expect(pet.petimage, 'image_url');
    expect(pet.petinfo, 'Friendly dog');
    expect(pet.openbooking, 'yes');
    expect(pet.booked, 'no');
  });

  test('3. PetEntity should correctly convert to JSON', () {
    final pet = PetEntity(
      petId: '123',
      petname: 'Fluffy',
      type: 'Dog',
      petimage: 'image_url',
      petinfo: 'Friendly dog',
      openbooking: 'yes',
      booked: 'no',
    );

    final petJson = pet.toJson();

    expect(petJson['_id'], '123');
    expect(petJson['petname'], 'Fluffy');
    expect(petJson['type'], 'Dog');
    expect(petJson['petimage'], 'image_url');
    expect(petJson['petinfo'], 'Friendly dog');
    expect(petJson['openbooking'], 'yes');
    expect(petJson['booked'], 'no');
  });

  test('4. Two PetEntity objects with the same data should be equal', () {
    final pet1 = PetEntity(
      petId: '123',
      petname: 'Fluffy',
      type: 'Dog',
      petimage: 'image_url',
      petinfo: 'Friendly dog',
      openbooking: 'yes',
      booked: 'no',
    );

    final pet2 = PetEntity(
      petId: '123',
      petname: 'Fluffy',
      type: 'Dog',
      petimage: 'image_url',
      petinfo: 'Friendly dog',
      openbooking: 'yes',
      booked: 'no',
    );

    expect(pet1, equals(pet2));
  });

  test('6. PetOwnerEntity should be instantiated correctly', () {
    final owner = PetOwnerEntity(
      ownerId: 'owner123',
      name: 'John Doe',
      email: 'johndoe@example.com',
      phone: '1234567890',
      address: '123 Main St',
      image: 'owner_image_url',
      pets: [],
    );

    expect(owner.ownerId, 'owner123');
    expect(owner.name, 'John Doe');
    expect(owner.email, 'johndoe@example.com');
    expect(owner.phone, '1234567890');
    expect(owner.address, '123 Main St');
    expect(owner.image, 'owner_image_url');
    expect(owner.pets, isEmpty);
  });

  test('7. PetOwnerEntity should correctly convert from JSON', () {
    final ownerJson = {
      '_id': 'owner123',
      'name': 'John Doe',
      'email': 'johndoe@example.com',
      'phone': '1234567890',
      'address': '123 Main St',
      'image': 'owner_image_url',
      'pets': [],
    };

    final owner = PetOwnerEntity.fromJson(ownerJson);

    expect(owner.ownerId, 'owner123');
    expect(owner.name, 'John Doe');
    expect(owner.email, 'johndoe@example.com');
    expect(owner.phone, '1234567890');
    expect(owner.address, '123 Main St');
    expect(owner.image, 'owner_image_url');
    expect(owner.pets, isEmpty);
  });

  test('8. PetOwnerEntity should correctly handle an empty pets list', () {
    final owner = PetOwnerEntity(
      ownerId: 'owner123',
      name: 'John Doe',
      email: 'johndoe@example.com',
      phone: '1234567890',
      address: '123 Main St',
      image: 'owner_image_url',
      pets: [],
    );

    expect(owner.pets, isEmpty);
  });

  test('9. PetOwnerEntity should allow having multiple pets', () {
    final pet1 = PetEntity(
      petId: '123',
      petname: 'Fluffy',
      type: 'Dog',
    );

    final pet2 = PetEntity(
      petId: '124',
      petname: 'Whiskers',
      type: 'Cat',
    );

    final owner = PetOwnerEntity(
      ownerId: 'owner123',
      name: 'John Doe',
      email: 'johndoe@example.com',
      phone: '1234567890',
      address: '123 Main St',
      image: 'owner_image_url',
      pets: [pet1, pet2],
    );

    expect(owner.pets.length, 2);
    expect(owner.pets[0].petname, 'Fluffy');
    expect(owner.pets[1].petname, 'Whiskers');
  });

  test('10. Two PetOwnerEntity objects with the same data should be equal', () {
    final owner1 = PetOwnerEntity(
      ownerId: 'owner123',
      name: 'John Doe',
      email: 'johndoe@example.com',
      phone: '1234567890',
      address: '123 Main St',
      image: 'owner_image_url',
      pets: [],
    );

    final owner2 = PetOwnerEntity(
      ownerId: 'owner123',
      name: 'John Doe',
      email: 'johndoe@example.com',
      phone: '1234567890',
      address: '123 Main St',
      image: 'owner_image_url',
      pets: [],
    );

    expect(owner1, equals(owner2));
  });
}
