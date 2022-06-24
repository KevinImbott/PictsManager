import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/ScreenPreview.dart';

import '../screens/ScreenChoosePicture.dart';


// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  TakePictureScreen({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late bool camera;
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    camera = true;
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.cameras[2],
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) async {
    final cameras = await availableCameras();
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenChoosePicture(cameras: cameras)));
    }
    if (_selectedIndex == 1) {
      savePicture();
    }
    if (_selectedIndex == 2) {
      toggleCam();
    }
  }

  void savePicture() async {
    try {
      await _initializeControllerFuture;
        // Attempt to take a picture and get the file `image`
        // where it was saved.
        final image = await _controller.takePicture();

        // If the picture was taken, display it on a new screen.
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScreenPreview(
              // Pass the automatically generated path to
              // the DisplayPictureScreen widget.
              imgPath: image.path,
            ),
          ),
        );
    } catch (e) {
      print(e);
    }
  }

  void toggleCam() {
    camera = !camera;
    setState(() {
      if (camera) {
        _controller = CameraController(widget.cameras[1], ResolutionPreset.high);
        _initializeControllerFuture = _controller.initialize();
      } else {
        _controller = CameraController(widget.cameras[2], ResolutionPreset.high);
        _initializeControllerFuture = _controller.initialize();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
      appBar: AppBar(title: const Text('Take a picture'), backgroundColor: const Color.fromRGBO(2, 2, 39, 1)),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
            
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color.fromRGBO(236, 236, 254, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back_ios_new, size: 40), label: 'Back'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined, size: 40), label: 'Take a picture'),
          BottomNavigationBarItem(icon: Icon(Icons.cameraswitch_rounded, size: 40), label: 'Switch'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(226, 101, 47, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}