import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/ScreenChoosePicture.dart';
import 'package:mobile/screens/ScreenHome.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  Future<List<CameraDescription>> cameras = availableCameras();
  List<Widget> _widgetOptions = [const ScreenHome(),
      ScreenChoosePicture(cameras: cameras),];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        initCam();
        setState(() { });
    });
  }
  void initCam () async {
    cameras = await availableCameras();
    _widgetOptions = [
      const ScreenHome(),
      ScreenChoosePicture(cameras: cameras),
      //profile_component ici
    ];
    
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    initCam();
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
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
