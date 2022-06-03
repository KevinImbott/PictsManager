import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/ScreenChoosePicture.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    final cameras = await availableCameras();
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenChoosePicture(cameras: cameras)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      );
    
  }
}
