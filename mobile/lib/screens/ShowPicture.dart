import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobile/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../components/Navbar.dart';

class ShowPicture extends StatefulWidget {
  const ShowPicture({Key? key, required this.image, required this.id})
      : super(key: key);

  final String image;
  final String id;

  @override
  State<ShowPicture> createState() => _ShowPicture();
}

class _ShowPicture extends State<ShowPicture> {
  String get image => widget.image;
  String get id => widget.id;
  String name = '';
  List tags = [];

  @override
  void initState() {
    super.initState();
    _loadPicture(id);
  }

  Future<void> _loadPicture(pictureId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';

    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE2NTc0NjYzMDV9.zc7UkDGzNgNwNt5dIU5tYfQcOX7z1GNfnAAXxDGH8gA";
    var url = Uri.parse('http://172.168.1.6:3000/pictures/' + pictureId);
    print(url);
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) async {
      print(response.statusCode);
      if (response.statusCode == 200) {
        var tagsJson = jsonDecode(response.body);
        print(tagsJson);
        List tagsList = List.from(tagsJson["tags"]);

        List listTagsTemp = [];
        for (int i = 0; i < tagsList.length; i++) {
          listTagsTemp.add(tagsList[i].split(' ').join(''));
        }

        setState(() {
          name = tagsJson["name"];
          tags.addAll(listTagsTemp);
        });
      }
    });
  }

  Widget build(BuildContext context) {
    print(name);
    print(tags);
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      iconSize: 40.0,
                      icon: Icon(
                        Icons.arrow_back,
                        color: const Color.fromRGBO(226, 101, 47, 1),
                      ),
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      })),
            ),
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 2,
                  child: Container(
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage(image),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Text(
                    name,
                    style:
                    TextStyle(
                        fontSize: 40, color: Color.fromRGBO(226, 101, 47, 1),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Row(
                            children: tags
                                .map(
                                  (item) => new Text("#"+item+" ", style: TextStyle(
                                      fontSize: 26, color: Color.fromRGBO(40, 100, 200, 1),    decoration: TextDecoration.underline,
                                  ),
                                  ),
                                )
                                .toList()))),
              ],
            )
          ])),
      backgroundColor: Color.fromRGBO(2, 2, 39, 1),
    );
  }
}
