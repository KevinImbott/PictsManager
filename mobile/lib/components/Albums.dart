import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile/components/Photos.dart';
import 'package:mobile/screens/ShowPicture.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Navbar.dart';

class Albums extends StatefulWidget {
  const Albums({Key? key, required this.album}) : super(key: key);
  final bool album;

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  bool get album => widget.album;
  late List albumsList = [];
  late List _albumsCreate = [("Nouveau")];
  late List _albums = [];
  late List _albumsReferenceID = [];

  final albumController = TextEditingController();
  @override
  void dispose() {
    albumController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';

    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NTY3NzkxNTV9.ICLwkXgJcbyOL2YV8ScR9lixc0YqGzNmIwlsbDxGjXY";
    var url = Uri.parse('http://172.168.1.6:3000/albums');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) async {
      if (response.statusCode == 200) {
        var tagsJson = jsonDecode(response.body);
        List tags = List.from(tagsJson);
        List tList = [];
        for (int i = 0; i < tags.length; i++) {
          tList.add(tags[i]["name"]);
        }
        setState(() {
          _albums.addAll(tList);
          _albumsReferenceID.addAll(tags);
        });
      }
    });
  }

  Widget build(BuildContext context) {
    albumsList = [..._albumsCreate, ..._albums];


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
                    return GestureDetector(
                        onTap: () {
                          if (index == 0 && album == true) {
                            print("openAlert");
                            _CreateAlbumDialog(context);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Photos(album: true)),
                            );
                          }
                        },
                        onLongPress: () {
                          print(index);
                          print(album);
                          if (index != 0 && album == true) {
                            DialogAlbum(context, albumsList[index]);
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
                                  albumsList[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
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

  void DialogAlbum(BuildContext context, name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Color.fromRGBO(64, 63, 102, 1),
            title: new Text(
              "Album " + name,
              style: TextStyle(color: Colors.white),
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                height: 15,
              ),
              ListTile(
                  leading: Icon(Icons.folder_copy,
                      color: Color.fromRGBO(226, 101, 47, 1)),
                  title: Text("Partager",
                      style: TextStyle(color: Color.fromRGBO(226, 101, 47, 1))),
                  onTap: () {}),
              ListTile(
                  leading: Icon(Icons.delete,
                      color: Color.fromRGBO(226, 101, 47, 1)),
                  title: Text("Supprimer",
                      style: TextStyle(color: Color.fromRGBO(226, 101, 47, 1))),
                  onTap: () {
                    _acceptDeleteDialog(context, name);
                  }),
              ListTile(
                  leading: Icon(Icons.backspace,
                      color: Color.fromRGBO(234, 234, 234, 1.0)),
                  title: Text("Annuler",
                      style:
                          TextStyle(color: Color.fromRGBO(234, 234, 234, 1.0))),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ]));
      },
    );
  }

  void _acceptDeleteDialog(BuildContext context, name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(64, 63, 102, 1),
          title: new Text(
            "SUPPRIMER",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "Voulez-vous vous supprimer l'album: "+ name +" ?",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
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
              child: new Text("Supprimer", style: TextStyle(color: Colors.white),),
              onPressed: () {
                deleteFolder(name);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Navbar(
                          index: 2,
                        )));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteFolder(nameDelete) async {
    var idToDelete;
    for (var post in _albumsReferenceID) {
      if(post['name'] == nameDelete){
        idToDelete=post['id'];
      }
    }
    print(idToDelete);
    if(idToDelete != null) {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwt') ?? '';

      token =
      "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NTY3NzkxNTV9.ICLwkXgJcbyOL2YV8ScR9lixc0YqGzNmIwlsbDxGjXY";
      var url = Uri.parse("http://172.168.1.6:3000/albums/$idToDelete");
      await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }).then((response) async {
        print(response.statusCode);
        if (response.statusCode == 204) {
          print(nameDelete + " deleted");
        }
      });
    }
  }
  void _CreateAlbumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(64, 63, 102, 1),
          title: Text(
            "Crée un Album:",
            style: TextStyle(color: Colors.white),
          ),
          content: SizedBox(
              height: 100,
              child: Column(children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: albumController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    labelStyle: TextStyle(
                        color: const Color.fromRGBO(236, 236, 254, 1),
                        fontSize: MediaQuery.of(context).size.height * 0.020),
                    hintText: "Nom d'album",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ])),
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
                  child: new Text(
                    "Créer",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _createAlbum();
                  },
                ),
              ],
            )
      ]);
      },
    );
  }

  Future<void> _createAlbum() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';
    if (albumController != null) {
      token =
          "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NTY3NzkxNTV9.ICLwkXgJcbyOL2YV8ScR9lixc0YqGzNmIwlsbDxGjXY";
      var url = Uri.parse('http://172.168.1.6:3000/albums');
      await http
          .post(url,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(<String, String>{'name': albumController.text}))
          .then((response) async {
        if (response.statusCode == 201) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Navbar(
                        index: 2,
                      )));
        }
      });
    }
  }
}
