import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile/components/Navbar.dart';
import 'package:mobile/screens/login.dart';
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
  String? token;

  @override
  Widget build(BuildContext context) {
    if (token != null) {
      return MaterialApp(
        title: 'Welcome to Flutter',
        home: Navbar()
      ); 
    }
    else {
      return MaterialApp(
        title: 'Welcome to Flutter',
        home: MyLoginPage(token: token)
      ); 
    }
  }
}