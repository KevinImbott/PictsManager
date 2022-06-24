import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/ScreenChoosePicture.dart';

import '../screens/ScreenHome.dart';
import '../screens/profile.dart';

class Navbar extends StatefulWidget {
  Navbar({Key? key, this.index}) : super(key: key);

  int? index = 0;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? 0;
  }

  static List<Widget> _widgetOptions = <Widget>[
    ScreenHome(),
    ScreenChoosePicture(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color.fromRGBO(236, 236, 254, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_sharp, size: 40), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_a_photo, size: 40), label: 'Add a photo'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined, size: 40), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(226, 101, 47, 1),
        onTap: _onItemTapped,
        ),
    );
  }
}
