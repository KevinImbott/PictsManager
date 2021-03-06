import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/Navbar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ScreenPreview extends StatefulWidget {
  const ScreenPreview({ Key? key, required this.imagePath }) : super(key: key);

  final String imagePath;

  @override
  State<ScreenPreview> createState() => _ScreenPreview();
}

class _ScreenPreview extends State<ScreenPreview> {
  late Image img;
  late Uri path;
  TextEditingController name = TextEditingController();
  TextEditingController tags = TextEditingController();
  late SharedPreferences prefs;
  String token = '';
  

  @override
  void initState() {
    img = Image.file(File(widget.imagePath));
    path = Uri.file(widget.imagePath);
    initPref();
    super.initState();
  }

  void initPref() async {
    final result = await FlutterImageCompress.compressWithFile(
      widget.imagePath,
      quality: 80,
    );
    
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwt') ?? '';
    setState(() {
      img = Image.memory(result!);
    });
  }

  void sendPic () async {
    prefs = await SharedPreferences.getInstance();

    var uri = Uri.parse('http://54.36.191.51:3000/pictures');
    var req = http.MultipartRequest('POST', uri);
    req.headers['Authorization'] = 'Bearer ' + token;
    req.fields['name'] = name.text;
    List<dynamic> arr = tags.text.split(',');
    req.fields['tags'] = json.encode(arr);
    req.files.add(await http.MultipartFile.fromPath('img', widget.imagePath, contentType: MediaType('image', 'jpeg')));
    req.send().then((response) {
      print(response.statusCode);
      print(response.toString());
      if (response.statusCode == 201) {
        print("Uploaded!");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Navbar(index: 2)));
      }
      else {
        print(response.toString());
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Column(
          children: [
            Row(
              children: [
                Container(
                  width: 220,
                  margin: const EdgeInsets.only(top: 50, left: 48, bottom: 20, right: 5),
                  child: TextFormField(
                    controller: name,
                    style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(236, 236, 254, 0.25),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color.fromRGBO(236, 236, 254, 1), width: 3),
                        borderRadius: BorderRadius.circular(30.0)
                      ),
                      hintStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                      hintText: 'Name',
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  margin: const EdgeInsets.only(top: 50, bottom: 20, left: 5),
                  child: TextFormField(
                    controller: tags,
                    style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 25),
                      filled: true,
                      fillColor: const Color.fromRGBO(226, 101, 47, 0.75),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color.fromRGBO(226, 101, 47, 0.2), width: 3),
                        borderRadius: BorderRadius.circular(30.0)
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                      hintText: 'Tag',
                    ),
                  ),
                )
              ],
            ),
            Container(
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
              child: const Text('Submit')
            )
          ],
        ),
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
    );
  }
}