import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'screens/home/ScreenHome.dart';

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

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      title: 'Welcome to Flutter',
      home: ScreenHome()
    );
  }
}