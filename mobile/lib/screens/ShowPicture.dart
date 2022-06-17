import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/screens/profile.dart';

class ShowPicture extends StatefulWidget {
  const ShowPicture({Key? key, required this.image, required this.name})
      : super(key: key);

  final String image;
  final String name;
  @override
  State<ShowPicture> createState() => _ShowPicture();
}

class _ShowPicture extends State<ShowPicture> {
  String get image => widget.image;
  String get name => widget.name;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child:
               Container(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      iconSize: 40.0,
                      icon: Icon(
                        Icons.arrow_back,
                        color: const Color.fromRGBO(226, 101, 47, 1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile()),
                        );
                      })),
          ),
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage(image),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 40, color: Color.fromRGBO(226, 101, 47, 1)),
                    ),
                  ),
                ),
              ],
            )
          ])),
      backgroundColor: Color.fromRGBO(2, 2, 39, 1),
    );
  }
}
