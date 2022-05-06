import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImportPage extends StatefulWidget {
  const ImportPage({ Key? key }) : super(key: key);

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
    File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTmp = File(image.path);
      setState(() => this.image = imageTmp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(children: [
          image != null ? Image.file(image!) : FlutterLogo(),
          TextButton(
          style: TextButton.styleFrom(
            primary: Colors.blue,
            onSurface: Colors.red
          ),
          onPressed: () => pickImage(),
          child: const Text('Pick an image'),
        ),
        ],)
      ),
    );
    
  }
}