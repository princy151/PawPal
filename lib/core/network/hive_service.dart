import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pawpal/app/constants/hive_table_constant.dart';
import 'package:pawpal/features/auth/data/model/owner_hive_model.dart';


class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}pawpal.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(OwnerHiveModelAdapter());
  }


/*
  register box
  {
    fname : "asd",
    lname : "asd",
    batch : {batchId : 1, batchName : "Batch 1"},
    courses : [{courseId : 1, courseName : "Course 1"}, {courseId : 2, courseName : "Course 2"}],
  }
*/

// OR

/*
 {
    fname : "asd",
    lname : "asd",
    batch : 1,
    courses : [1,3,4],
  }
*/

  // Auth Queries
  Future<void> register(OwnerHiveModel auth) async {
    var box = await Hive.openBox<OwnerHiveModel>(HiveTableConstant.ownerBox);
    await box.put(auth.ownerId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<OwnerHiveModel>(HiveTableConstant.ownerBox);
    await box.delete(id);
  }

  Future<List<OwnerHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<OwnerHiveModel>(HiveTableConstant.ownerBox);
    return box.values.toList();
  }

  // Login using username and password
  Future<OwnerHiveModel?> login(String username, String password) async {
    // var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    // var auth = box.values.firstWhere(
    //     (element) =>
    //         element.username == username && element.password == password,
    //     orElse: () => AuthHiveModel.initial());
    // return auth;

    var box = await Hive.openBox<OwnerHiveModel>(HiveTableConstant.ownerBox);
    var student = box.values.firstWhere((element) =>
        element.name == username && element.password == password);
    box.close();
    return student;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.ownerBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.sitterBox);
  }

  // Clear Student Box
  Future<void> clearStudentBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.ownerBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
