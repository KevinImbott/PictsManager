import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../components/ImportButton.dart';
import '../components/Navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({ Key? key }) : super(key: key);
  
  @override
  State<ScreenHome> createState() => _ScreenHome();
}

class _ScreenHome extends State<ScreenHome> {
  SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(2, 2, 39, 1),
    );
  }
}
