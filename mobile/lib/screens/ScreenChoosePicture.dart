import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img2;
import 'package:mobile/components/Camera.dart';
import 'package:image_picker/image_picker.dart' as img;
import 'package:mobile/screens/ScreenPreview.dart';

import '../components/Navbar.dart';

class ScreenChoosePicture extends StatefulWidget {
  const ScreenChoosePicture({Key? key, required this.cameras})
      : super(key: key);

  final List<CameraDescription> cameras;

  @override
  State<ScreenChoosePicture> createState() => _ScreenChoosePicture();
}

class _ScreenChoosePicture extends State<ScreenChoosePicture> {
  File? image;
  String imagePath = '';
  late String imgPathconvert = '';

  Future pickImage() async {
    try {
      final image =
          await img.ImagePicker().pickImage(source: img.ImageSource.gallery);
      if (image == null) return;
      imagePath = image.path;
      final imageTmp = File(image.path);
      setState(() => this.image = imageTmp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    print("testCompressFile");

    final result = await FlutterImageCompress.compressWithFile(
      imagePath,
      quality: 10,
    );

    Image image = Image.memory(result!);
    return image;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(236, 236, 254, 0.25),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.photo_camera),
                iconSize: 80,
                color: const Color.fromRGBO(226, 101, 47, 1),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TakePictureScreen(cameras: widget.cameras)));
                },
              ),
              const VerticalDivider(
                  color: Colors.white, thickness: 2, indent: 0, endIndent: 0),
              IconButton(
                icon: const Icon(Icons.photo_size_select_actual_rounded),
                iconSize: 80,
                color: const Color.fromRGBO(226, 101, 47, 1),
                onPressed: () async {
                  Image tmpImage = await pickImage();
                  print("good " + imagePath);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ScreenPreview(image: tmpImage)));
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(),
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
    );
  }
}


// Navigator.push(context, 
//               MaterialPageRoute(builder: (context) => TakePictureScreen(cameras: widget.cameras)));