import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:pawpal/core/error/failure.dart';
import 'package:pawpal/features/auth/domain/entity/pet_owner_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Save Owner ID to SharedPreferences
  Future<Either<Failure, void>> saveOwnerId(String ownerId) async {
    try {
      await _sharedPreferences.setString('ownerId', ownerId);
      print("Saved Owner ID: $ownerId"); // Debug log
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Get owner ID from SharedPreferences
  Future<Either<Failure, String>> getOWnerId() async {
    try {
      final ownerId = _sharedPreferences.getString('ownerId');
      if (ownerId == null || ownerId.isEmpty) {
        return const Left(SharedPrefsFailure(message: 'Owner ID not found.'));
      }
      print("Retrieved owner ID: $ownerId"); // Debug log
      return Right(ownerId);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<bool> setOwner(Map<String, dynamic> owner) async {
    try {
      if (owner.isEmpty) {
        throw Exception("owner data cannot be empty.");
      }
      String ownerDataString = jsonEncode(owner);
      print("owner data: $ownerDataString"); // Debug log
      await _sharedPreferences.setString('owner', ownerDataString);
      return true;
    } catch (e) {
      print("Error saving owner data: $e"); // Debug log
      return false;
    }
  }

  Future<Map<String, dynamic>?> getOwner() async {
    try {
      String? ownerDataString = _sharedPreferences.getString('owner');
      print("owner data string: $ownerDataString"); // Debug log
      if (ownerDataString == null || ownerDataString.isEmpty) {
        return null;
      }
      Map<String, dynamic> ownerData = jsonDecode(ownerDataString);
      return ownerData;
    } catch (e) {
      return null;
    }
  }

  // Update user data in SharedPreferences
  Future<bool> updateOwner(Map<String, dynamic> updatedOwnerData) async {
    print("updatedOwner called with data: $updatedOwnerData"); // Debug log
    try {
      // Retrieve the current OwnerData
      final currentOwnerData = await getOwner();
      print("getting owner $currentOwnerData");

      if (currentOwnerData == null) {
        print("No owner data found in SharedPreferences.");
        return false; // No sitter data found to update
      }

      // Merge old data with new updated data
      final Map<String, dynamic> updatedData = {
        ...currentOwnerData, // Keep existing data
        ...updatedOwnerData, // Overwrite with new values
      };
      print("Updated owner Data to Merge: $updatedOwnerData");

      // Save the updated data back to SharedPreferences
      bool isUpdated = await setOwner(updatedData);
      print("Is UPDATED::::: $isUpdated");
      return isUpdated;
    } catch (e) {
      print("Error updating owner data: ${e.toString()}");
      return false;
    }
  }

  Future<bool> deleteOwner() async {
    try {
      await _sharedPreferences.remove('owner');
      return true;
    } catch (e) {
      return false;
    }
  }

// Save sitter ID to SharedPreferences
  Future<Either<Failure, void>> saveSitterId(String sitterId) async {
    try {
      await _sharedPreferences.setString('sitterId', sitterId);
      print("Saved Sitter ID: $sitterId"); // Debug log
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Get sitter ID from SharedPreferences
  Future<Either<Failure, String>> getSitterId() async {
    try {
      final sitterId = _sharedPreferences.getString('sitterId');
      if (sitterId == null || sitterId.isEmpty) {
        return const Left(SharedPrefsFailure(message: 'Sitter ID not found.'));
      }
      print("Retrieved Sitter ID: $sitterId"); // Debug log
      return Right(sitterId);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<bool> setSitter(Map<String, dynamic> sitter) async {
    try {
      if (sitter.isEmpty) {
        throw Exception("Sitter data cannot be empty.");
      }
      String sitterDataString = jsonEncode(sitter);
      print("Sitter data: $sitterDataString"); // Debug log
      await _sharedPreferences.setString('sitter', sitterDataString);
      return true;
    } catch (e) {
      print("Error saving sitter data: $e"); // Debug log
      return false;
    }
  }

  Future<Map<String, dynamic>?> getSitter() async {
    try {
      String? sitterDataString = _sharedPreferences.getString('sitter');
      print("Sitter data string: $sitterDataString"); // Debug log
      if (sitterDataString == null || sitterDataString.isEmpty) {
        return null;
      }
      Map<String, dynamic> sitterData = jsonDecode(sitterDataString);
      return sitterData;
    } catch (e) {
      return null;
    }
  }

  // Update user data in SharedPreferences
  Future<bool> updateSitter(Map<String, dynamic> updatedSitterData) async {
    print("updateSitter called with data: $updatedSitterData"); // Debug log
    try {
      // Retrieve the current sitter data
      final currentSitterData = await getSitter();
      print("getting sitter $currentSitterData");

      if (currentSitterData == null) {
        print("No sitter data found in SharedPreferences.");
        return false; // No sitter data found to update
      }

      // Merge old data with new updated data
      final Map<String, dynamic> updatedData = {
        ...currentSitterData, // Keep existing data
        ...updatedSitterData, // Overwrite with new values
      };
      print("Updated Sitter Data to Merge: $updatedSitterData");

      // Save the updated data back to SharedPreferences
      bool isUpdated = await setSitter(updatedData);
      print("Is UPDATED::::: $isUpdated");
      return isUpdated;
    } catch (e) {
      print("Error updating sitter data: ${e.toString()}");
      return false;
    }
  }

  Future<bool> deleteSitter() async {
    try {
      await _sharedPreferences.remove('sitter');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<PetOwnerEntity?> getLoggedInUser(
      TokenSharedPrefs tokenSharedPrefs) async {
    final ownerData = await tokenSharedPrefs.getOwner();
    if (ownerData != null) {
      return PetOwnerEntity.fromJson(ownerData);
    }
    return null;
  }
}
