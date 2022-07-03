import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/components/AlbumsList.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Navbar.dart';

class DialogChooseAlbums extends StatefulWidget {
  const DialogChooseAlbums({Key? key, required this.pictureId})
      : super(key: key);
  final String pictureId;

  @override
  State<DialogChooseAlbums> createState() => _DialogChooseAlbums();
}

class _DialogChooseAlbums extends State<DialogChooseAlbums> {
  late List _itemsAlbumsCheckBox = [];

  bool checked = true;
  String get pictureId => widget.pictureId;

  Future<void> _loadAlbumsChecked(pictureId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';

    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE2NTc0NjYzMDV9.zc7UkDGzNgNwNt5dIU5tYfQcOX7z1GNfnAAXxDGH8gA";
    var url = Uri.parse('http://172.168.1.6:3000/pictures/' + pictureId);
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) async {
      if (response.statusCode == 200) {
        var tagsJson = jsonDecode(response.body);
        tagsJson = tagsJson["albums"];
        List tags = List.from(tagsJson);
        for (int i = 0; i < tagsJson.length; i++) {
          setState(() {
            _itemsAlbumsCheckBox.add({
              "id": tags[i]["id"],
              "name": tags[i]["name"],
              "checked": tags[i]["on_album"]
            });
          });
        }
      }
    });
  }

  Future<void> _setAlbumsChecked(album_id) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';

    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE2NTc0NjYzMDV9.zc7UkDGzNgNwNt5dIU5tYfQcOX7z1GNfnAAXxDGH8gA";
    var url = Uri.parse("http://172.168.1.6:3000/pictures/" +
        pictureId +
        "/add_or_delete_album");

    await http
        .post(url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, String>{
              'album_id': album_id.toString(),
            }))
        .then((response) async {
      if (response.statusCode == 200) {

      }
    });
  }

  @override
  initState() {
    super.initState();
    _loadAlbumsChecked(pictureId);
  }

  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromRGBO(64, 63, 102, 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'Placer dans un album',
            style: TextStyle(
                color: Color.fromRGBO(226, 101, 47, 1),
                fontSize: MediaQuery.of(context).size.height * 0.04),
          ),
          //  AlbumsList(albums: _itemsAlbums),
          Flexible(child: _buildList()),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: RaisedButton.icon(
                color: Color.fromRGBO(226, 101, 47, 1),
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                label: Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Navbar(
                              index: 2,
                            )));

                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView(
      children: _itemsAlbumsCheckBox.map((albumIndex) {

        return CheckboxListTile(
            tileColor: albumIndex["checked"] == true
                ? Color.fromRGBO(226, 101, 47, 0.75)
                : null,
            secondary: Icon(Icons.folder_copy,
                color: albumIndex["checked"] == false
                    ? Color.fromRGBO(226, 101, 47, 1)
                    : Colors.white),
            title: Text(
              albumIndex["name"],
              style: TextStyle(color: Colors.white),
            ),
            activeColor: Colors.white,
            checkColor: Color.fromRGBO(226, 101, 47, 1),
            side: albumIndex["checked"] == true
                ? BorderSide(width: 16.0, color: Colors.lightBlue.shade50)
                : BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
            value: albumIndex["checked"],
            onChanged: (val) {
              setState(
                () {
                  albumIndex["checked"] = val != true ? false : true;
                  _setAlbumsChecked(albumIndex["id"]);
                },
              );
            });
      }).toList(),
    );
  }
}
