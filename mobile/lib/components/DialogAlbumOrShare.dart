import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/components/AlbumsList.dart';
import 'package:mobile/components/DialogChooseAlbums.dart';
import 'package:mobile/screens/ShowPicture.dart';
import 'package:mobile/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'DialogChooseShare.dart';
import 'Navbar.dart';

class DialogAlbumOrShare extends StatefulWidget {
  const DialogAlbumOrShare(
      {Key? key, required this.pictureId, required this.albumsId})
      : super(key: key);

  final String pictureId;
  final String albumsId;

  @override
  State<DialogAlbumOrShare> createState() => _DialogAlbumOrShare();
}

class _DialogAlbumOrShare extends State<DialogAlbumOrShare> {
  String get albumsId => widget.albumsId;
  String get pictureId => widget.pictureId;

  Future<void> _requestDeletes(albumsId, pictureId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';

    //
    var url = Uri.parse("");
    if (albumsId != "") {
      url = Uri.parse('http://54.36.191.51:3000/albums/' + albumsId);
    } else {
      url = Uri.parse('http://54.36.191.51:3000/pictures/' + pictureId);
    }
    print(url);
    await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) async {});
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(64, 63, 102, 1),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading:
                Icon(Icons.folder_copy, color: Color.fromRGBO(226, 101, 47, 1)),
            title: Text("Albums",
                style: TextStyle(color: Color.fromRGBO(226, 101, 47, 1))),
            onTap: () => showDialog(
                context: context,
                builder: (context) => DialogChooseAlbums(
                      pictureId: pictureId,
                    )),
          ),
          ListTile(
            leading: Icon(Icons.share, color: Color.fromRGBO(226, 101, 47, 1)),
            title: Text("Partager",
                style: TextStyle(color: Color.fromRGBO(226, 101, 47, 1))),
            onTap: () => showDialog(
                context: context,
                builder: (context) => DialogChooseShare(
                      picture: '',
                      album: 'albums',
                    )),
          ),
          ListTile(
              leading:
                  Icon(Icons.delete, color: Color.fromRGBO(226, 101, 47, 1)),
              title: Text("Supprimer",
                  style: TextStyle(color: Color.fromRGBO(226, 101, 47, 1))),
              onTap: () {
                _chooseDialog(context, albumsId, pictureId);
              }),
          ListTile(
              leading: Icon(Icons.backspace,
                  color: Color.fromRGBO(234, 234, 234, 1.0)),
              title: Text("Annuler",
                  style: TextStyle(color: Color.fromRGBO(234, 234, 234, 1.0))),
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  void _chooseDialog(BuildContext context, albumsId, pictureId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Color.fromRGBO(64, 63, 102, 1),
            title: new Text(
              "Suppression",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Voulez-vous vous supprimer?",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new FlatButton(
                    child: new Text(
                      "Annuler",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                      color: Colors.orange,
                      child: new Text("Supprimer",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        _requestDeletes(albumsId, pictureId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Navbar(
                                      index: 2,
                                    )));
                      }),
                ],
              )
            ]);
      },
    );
  }
}
