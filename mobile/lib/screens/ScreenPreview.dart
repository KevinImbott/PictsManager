import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../components/Navbar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ScreenPreview extends StatefulWidget {
  const ScreenPreview({Key? key, required this.imgPath}) : super(key: key);

  final String imgPath;

  @override
  State<ScreenPreview> createState() => _ScreenPreview();
}

class _ScreenPreview extends State<ScreenPreview> {
  late Image img;
  late File file;
  late Uri path;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    img = Image.file(File(widget.imgPath));
    path = Uri.file(widget.imgPath);
  }


  void sendPic() async {
    var uri = Uri.parse('http://10.0.2.2:3000/pictures');
    var req = http.MultipartRequest('POST', uri);
    req.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJleHAiOjE2NTUzNjc1NTV9.n2p11b2wYlPbzWnru8FYcyJpCxX6O8IyDNwLU70vMAM';
    req.fields['name'] = name.text;
    req.fields['description'] = description.text;
    req.files.add(await http.MultipartFile.fromPath('img', widget.imgPath, contentType: MediaType('image', 'png')));
    req.send().then((response) {
      if (response.statusCode == 201) print("Uploaded!");
      else {
        print(response.toString());
        print('Buuggugggugu');
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: 220,
                margin: const EdgeInsets.only(
                    top: 50, left: 48, bottom: 20, right: 5),
                child: TextFormField(
                  controller: name,
                  style:
                      const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(236, 236, 254, 0.25),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(236, 236, 254, 1), width: 3),
                        borderRadius: BorderRadius.circular(30.0)),
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1)),
                    hintText: 'Name',
                  ),
                ),
              ),
              Container(
                width: 80,
                margin: const EdgeInsets.only(top: 50, bottom: 20, left: 5),
                child: TextFormField(
                  controller: description,
                  style:
                      const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 25),
                    filled: true,
                    fillColor: const Color.fromRGBO(226, 101, 47, 0.75),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(226, 101, 47, 0.2), width: 3),
                        borderRadius: BorderRadius.circular(30.0)),
                    hintStyle: const TextStyle(color: Colors.white),
                    hintText: 'Tag',
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 550,
            height: 400,
            child: img,
          ),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(226, 101, 47, 1),
                primary: Colors.white,
                fixedSize: const Size(100, 40),
              ),
              onPressed: () {
                sendPic();
              },
              child: const Text('Submit')),
          
          //add container for image
        ],
      ),
      bottomNavigationBar: const Navbar(),
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
    );
  }
}
