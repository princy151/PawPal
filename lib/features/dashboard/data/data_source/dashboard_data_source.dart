import 'package:pawpal/features/auth/domain/entity/pet_sitter_entity.dart';

abstract interface class IDashboardDataSource {
  Future<List<PetSitterEntity>> getSitters();
}
