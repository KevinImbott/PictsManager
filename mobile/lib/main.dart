import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile/components/Navbar.dart';
import 'package:mobile/screens/login.dart';
import 'package:mobile/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splashscreen/splashscreen.dart';
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
    return MaterialApp(
        title: 'App starting...',
        home: SplashScreen(
          seconds: 0,
          navigateAfterSeconds: token != null?Navbar(): MyLoginPage(token: token),
          title: new Text(
            'PictsManager',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                color: Colors.orange),
          ),
          //backgroundColor: Color.fromRGBO(2, 2, 39, 1),
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(2, 2, 39, 1),
              Color.fromRGBO(9, 9, 79, 1.0),
            ],
          ),
          loaderColor: Colors.orange,
        ));
    }
  }
