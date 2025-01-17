import 'package:flutter/material.dart';
import 'package:pawpal/app/app.dart';
import 'package:pawpal/app/di/di.dart';
import 'package:pawpal/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // await HiveService().clearStudentBox();

  await initDependencies();

  runApp(
    App(),
  );
}
