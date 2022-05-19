import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/screens/ChoosePicture/component/Camera.dart';

class ScreenChoosePicture extends StatefulWidget {
  const ScreenChoosePicture({ Key? key, required this.cameras }) : super(key: key);
  
  final List<CameraDescription> cameras;

  @override
  State<ScreenChoosePicture> createState() => _ScreenChoosePicture();
}

class _ScreenChoosePicture extends State<ScreenChoosePicture> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(226, 101, 47, 1)
              ),
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => TakePictureScreen(cameras: widget.cameras)));
            },
            child: const Text('Prendre une photo',
            style: TextStyle(color: Color.fromRGBO(236, 236, 254, 1) ))
          ),
          //HandleCamera(camera: widget.camera)
        ],)
        
        
      ),
      
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
    );
  }
}