import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/components/Photos.dart';
import 'package:mobile/screens/ShowPicture.dart';

class AlbumItem {
  final String name;
  AlbumItem(this.name);
}

class Albums extends StatefulWidget {
  const Albums({Key? key, required this.album}) : super(key: key);
  final bool album;

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  bool get album => widget.album;

  late List<AlbumItem> albumsList = [];
  late List<AlbumItem> _albumsCreate = [AlbumItem("Nouveau")];
  List<AlbumItem> _albums = [
    AlbumItem("main"),
    AlbumItem("Perso"),
    AlbumItem("Work"),
  ];
  @override
  initState() {
    super.initState();
    albumsList = [..._albumsCreate, ..._albums];
  }

  Widget build(BuildContext context) {
    return SizedBox(
        height: 380, // Some height
        child: Column(children: [
          Flexible(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 3,
                  ),
                  itemCount: albumsList.length,
                  itemBuilder: (context, index) {
                    print(context);
                    print(index);
                    return GestureDetector(
                        onTap: () {
                          if (index == 0 && album == true) {
                            print("openAlert");
                            _showDialog(context);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Photos(album: true)),
                            );
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                width: 100.00,
                                height: 100.00,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: index == 0
                                        ? ExactAssetImage(
                                            'img/folderCreate.png')
                                        : ExactAssetImage(
                                            'img/folderAlbums.png'),
                                    fit: BoxFit.fitHeight,
                                  ),
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  albumsList[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Color.fromRGBO(226, 101, 47, 1)),
                                ),
                              ],
                            ),
                          ],
                        )
                        //   Text(_albums[index].name)
                        );
                  }))
        ]));
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Crée un Album:"),
        content: SizedBox(
            height: 100,
            child: Column(children: [
              TextFormField(
                style: TextStyle(
                    color: const Color.fromRGBO(0, 0, 0, 1.0),
                    fontSize: MediaQuery.of(context).size.height * 0.020),
                onChanged: (val) {

                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: const Color.fromRGBO(14, 14, 14, 1.0),
                      fontSize: MediaQuery.of(context).size.height * 0.020),
                  hintText: "Nom d'album",
                  hintStyle:
                      const TextStyle(color: Color.fromRGBO(105,105,105, 1.0)),
                ),
              ),
            ])),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Annuler"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text("Créer"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
