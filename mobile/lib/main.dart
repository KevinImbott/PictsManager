import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'screens/ScreenHome.dart';

void main() {
  try {
    WidgetsFlutterBinding.ensureInitialized();
  } on CameraException catch (e) {
    print(e.code);
    print(e.description);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  SharedPreferences? token;

  @override
  Widget build(BuildContext context) {
    if (token != null) {
      return const MaterialApp(
        title: 'Welcome to Flutter',
        home: ScreenHome()
      ); 
    }
    else {
      return const MaterialApp(
        title: 'Welcome to Flutter',
        home: MyHomePage()
      ); 
    }
  }
}