import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/components/AlbumsList.dart';
import 'package:mobile/components/DialogChooseAlbums.dart';
import 'package:mobile/screens/ShowPicture.dart';
import 'package:mobile/screens/profile.dart';

import 'DialogChooseShare.dart';

class DialogAlbumOrShare extends StatefulWidget {
  const DialogAlbumOrShare({Key? key}) : super(key: key);

  @override
  State<DialogAlbumOrShare> createState() => _DialogAlbumOrShare();
}

class _DialogAlbumOrShare extends State<DialogAlbumOrShare> {
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
              leading: Icon(Icons.folder_copy,
                  color: Color.fromRGBO(226, 101, 47, 1)),
              title: Text("Albums",
                  style: TextStyle(color: Color.fromRGBO(226, 101, 47, 1))),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DialogChooseAlbums()));
              }),
          ListTile(
              leading:
                  Icon(Icons.share, color: Color.fromRGBO(226, 101, 47, 1)),
              title: Text("Partager",
                  style: TextStyle(color: Color.fromRGBO(226, 101, 47, 1))),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DialogChooseShare()));
              }),
          ListTile(
              leading:
                  Icon(Icons.delete, color: Color.fromRGBO(226, 101, 47, 1)),
              title: Text("Supprimer",
                  style: TextStyle(color: Color.fromRGBO(226, 101, 47, 1))),
              onTap: () {
                _chooseDialog(context);
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

  void _chooseDialog(BuildContext context) {
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
              "Voulez-vous vous supprimer la photo?",
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
                      onPressed: () {}),
                ],
              )
            ]);
      },
    );
  }
}
