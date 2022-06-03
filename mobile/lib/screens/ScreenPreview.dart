import 'dart:io';
import 'package:flutter/material.dart';

import '../components/Navbar.dart';

class ScreenPreview extends StatefulWidget {
  const ScreenPreview({ Key? key, required this.imagePath }) : super(key: key);

  final String imagePath;

  @override
  State<ScreenPreview> createState() => _ScreenPreview();
}

class _ScreenPreview extends State<ScreenPreview> {
  late Image img;

  @override
  void initState() {
    img = Image.file(File(widget.imagePath));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: TextFormField(
                    style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(30.0)
                      ),
                      hintStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                      hintText: 'Name',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: TextFormField(
                    style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(30.0)
                      ),
                      hintStyle: const TextStyle(color: Color.fromRGBO(226, 101, 47, 1)),
                      hintText: 'Tag',
                    ),
                  ),
                )
              ],
            )
            ,
            Container(
              width: 550,
              height: 550,
              child: img,
            ),

          ],
        ),
    
      bottomNavigationBar: const Navbar(),
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
    );
  }
}