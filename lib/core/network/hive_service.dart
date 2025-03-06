// import 'dart:io';

// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pawpal/app/constants/hive_table_constant.dart';
// import 'package:pawpal/features/auth/data/model/owner_hive_model.dart';

// class HiveService {
//   static Future<void> init() async {
//     // Initialize the database
//     var directory = await getApplicationDocumentsDirectory();
//     var path = '${directory.path}/pawpal.db';

//     Hive.init(path);

//     // Register Adapters
//     Hive.registerAdapter(OwnerHiveModelAdapter());
//   }

//   // Auth Queries
//   Future<void> register(OwnerHiveModel auth) async {
//     var box = await Hive.openBox<OwnerHiveModel>(HiveTableConstant.ownerBox);
//     await box.put(auth.ownerId, auth);
//   }

//   Future<void> deleteAuth(String id) async {
//     var box = await Hive.openBox<OwnerHiveModel>(HiveTableConstant.ownerBox);
//     await box.delete(id);
//   }

//   Future<List<OwnerHiveModel>> getAllAuth() async {
//     var box = await Hive.openBox<OwnerHiveModel>(HiveTableConstant.ownerBox);
//     return box.values.toList();
//   }

//   // Login using username and password
//   Future<OwnerHiveModel?> login(String username, String password) async {
//     var box = await Hive.openBox<OwnerHiveModel>(HiveTableConstant.ownerBox);
//     try {
//       // Fetch the user based on username and password
//       var user = box.values.firstWhere((element) =>
//           element.name == username && element.password == password);
//       box.close();
//       return user;
//     } catch (e) {
//       box.close();
//       return null; // No matching user found
//     }
//   }

//   Future<void> clearAll() async {
//     await Hive.deleteBoxFromDisk(HiveTableConstant.ownerBox);
//     await Hive.deleteBoxFromDisk(HiveTableConstant.sitterBox);
//   }

//   // Clear Owner Box
//   Future<void> clearOwnerBox() async {
//     await Hive.deleteBoxFromDisk(HiveTableConstant.ownerBox);
//   }

//   Future<void> close() async {
//     await Hive.close();
//   }

//   // Fetch the currently logged-in owner (if any)
//   Future<OwnerHiveModel?> getCurrentUser() async {
//     var box = await Hive.openBox<OwnerHiveModel>(HiveTableConstant.ownerBox);
//     var auth = box.values.isNotEmpty ? box.values.first : null;
//     box.close();
//     return auth;
//   }

//   // Update Owner Profile (e.g., changing image or address)
//   Future<void> updateOwnerProfile(OwnerHiveModel owner) async {
//     var box = await Hive.openBox<OwnerHiveModel>(HiveTableConstant.ownerBox);
//     await box.put(owner.ownerId, owner);
//   }

//   // Upload profile image (if any image URL is provided)
//   Future<String> uploadImage(File file) async {
//     // Simulate the process of uploading the image and returning a URL
//     // In a real scenario, this would involve an API call to upload the file and get the URL
//     // Return a mock URL for now
//     return Future.value("https://example.com/uploads/${file.path}");
//   }
// }
