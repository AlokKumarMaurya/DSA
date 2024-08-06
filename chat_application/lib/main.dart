import 'dart:async';

import 'package:chat_application/utils/dependency_injection/inject_dependency.dart';
import 'package:chat_application/utils/getX_pages.dart';
import 'package:firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';

import 'utils/class_importer.dart';
StreamController notificationStreamController=StreamController();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await FirebaseService.init(notificationStreamController: notificationStreamController);
  InjectDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: GetXPages.appRoutes,
      initialRoute: GetXPages.initialRoute(),
    );
  }
}

