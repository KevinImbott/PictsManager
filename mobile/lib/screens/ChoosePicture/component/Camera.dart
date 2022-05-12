import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HandleCamera extends StatefulWidget {
  const HandleCamera({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  State<HandleCamera> createState() => _HandleCamera();
}

class _HandleCamera extends State<HandleCamera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }


  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Container();
  }
}