import 'package:flutter_test/flutter_test.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';

void main() {
  group('PetOwnerEntity Tests', () {
    test('Should create an instance of PetOwnerEntity', () {
      const petOwner = PetOwnerEntity(
        ownerId: '123',
        name: 'Princy Agrawal',
        email: 'princy@example.com',
        password: 'securepassword',
        petname: 'Buddy',
        type: 'Dog',
        address: '123 Pet Street',
        image: 'image_url',
      );

      expect(petOwner, isA<PetOwnerEntity>());
    });

    test('Should support value equality', () {
      const petOwner1 = PetOwnerEntity(
        ownerId: '123',
        name: 'Princy Agrawal',
        email: 'priincy@example.com',
        password: 'securepassword',
        petname: 'Buddy',
        type: 'Dog',
        address: '123 Pet Street',
        image: 'image_url',
      );

      const petOwner2 = PetOwnerEntity(
        ownerId: '123',
        name: 'Princy Agrawal',
        email: 'priincy@example.com',
        password: 'securepassword',
        petname: 'Buddy',
        type: 'Dog',
        address: '123 Pet Street',
        image: 'image_url',
      );

      expect(petOwner1, equals(petOwner2));
    });

    test('Should detect inequality between different instances', () {
      const petOwner1 = PetOwnerEntity(
        ownerId: '123',
        name: 'Alice',
        email: 'alice@example.com',
        password: 'pass123',
        petname: 'Max',
        type: 'Cat',
        address: '456 Pet Avenue',
      );

      const petOwner2 = PetOwnerEntity(
        ownerId: '456',
        name: 'Bob',
        email: 'bob@example.com',
        password: 'pass456',
        petname: 'Charlie',
        type: 'Dog',
        address: '789 Pet Lane',
      );

      expect(petOwner1, isNot(equals(petOwner2)));
    });

    test('Should allow null ownerId', () {
      const petOwner = PetOwnerEntity(
        name: 'Emma',
        email: 'emma@example.com',
        password: 'securepass',
        petname: 'Rocky',
        type: 'Bird',
        address: '321 Pet Road',
      );

      expect(petOwner.ownerId, isNull);
    });

    test('Should return correct properties in props list', () {
      const petOwner = PetOwnerEntity(
        ownerId: '001',
        name: 'Charlie Brown',
        email: 'charlie@example.com',
        password: 'pass321',
        petname: 'Snoopy',
        type: 'Dog',
        address: 'Peanuts Street',
      );

      expect(petOwner.props, [
        '001',
        'Charlie Brown',
        'charlie@example.com',
        'pass321',
        'Snoopy',
        'Dog',
        'Peanuts Street',
        null,
      ]);
    });

    test('Should compare instances correctly when image field is different',
        () {
      const petOwner1 = PetOwnerEntity(
        ownerId: '101',
        name: 'Mike',
        email: 'mike@example.com',
        password: 'pass999',
        petname: 'Rex',
        type: 'Dog',
        address: 'Hilltop Road',
        image: 'image1_url',
      );

      const petOwner2 = PetOwnerEntity(
        ownerId: '101',
        name: 'Mike',
        email: 'mike@example.com',
        password: 'pass999',
        petname: 'Rex',
        type: 'Dog',
        address: 'Hilltop Road',
        image: 'image2_url',
      );

      expect(petOwner1, isNot(equals(petOwner2)));
    });

    test('Should correctly compare instances with only required fields', () {
      const petOwner1 = PetOwnerEntity(
        name: 'Sarah',
        email: 'sarah@example.com',
        password: 'password123',
        petname: 'Fluffy',
        type: 'Rabbit',
        address: '123 Rabbit Hole',
      );

      const petOwner2 = PetOwnerEntity(
        name: 'Sarah',
        email: 'sarah@example.com',
        password: 'password123',
        petname: 'Fluffy',
        type: 'Rabbit',
        address: '123 Rabbit Hole',
      );

      expect(petOwner1, equals(petOwner2));
    });

    test('Should differentiate instances with different names', () {
      const petOwner1 = PetOwnerEntity(
        ownerId: '111',
        name: 'Alex',
        email: 'alex@example.com',
        password: 'alexpass',
        petname: 'Tommy',
        type: 'Dog',
        address: 'Park Avenue',
      );

      const petOwner2 = PetOwnerEntity(
        ownerId: '111',
        name: 'Jordan',
        email: 'alex@example.com',
        password: 'alexpass',
        petname: 'Tommy',
        type: 'Dog',
        address: 'Park Avenue',
      );

      expect(petOwner1, isNot(equals(petOwner2)));
    });

    test('Should compare instances when passwords are different', () {
      const petOwner1 = PetOwnerEntity(
        ownerId: '222',
        name: 'Michael',
        email: 'michael@example.com',
        password: 'password1',
        petname: 'Snowball',
        type: 'Cat',
        address: 'Feline Street',
      );

      const petOwner2 = PetOwnerEntity(
        ownerId: '222',
        name: 'Michael',
        email: 'michael@example.com',
        password: 'password2',
        petname: 'Snowball',
        type: 'Cat',
        address: 'Feline Street',
      );

      expect(petOwner1, isNot(equals(petOwner2)));
    });

    test('Should compare instances when pet type is different', () {
      const petOwner1 = PetOwnerEntity(
        ownerId: '333',
        name: 'Emma',
        email: 'emma@example.com',
        password: 'emmasecret',
        petname: 'Luna',
        type: 'Dog',
        address: 'Canine Street',
      );

      const petOwner2 = PetOwnerEntity(
        ownerId: '333',
        name: 'Emma',
        email: 'emma@example.com',
        password: 'emmasecret',
        petname: 'Luna',
        type: 'Cat',
        address: 'Canine Street',
      );

      expect(petOwner1, isNot(equals(petOwner2)));
    });
  });
}
