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

  late List<AlbumItem> TheListPictures = [];
  List<AlbumItem> _albums = [
    AlbumItem("main"),
    AlbumItem("Perso"),
    AlbumItem("Work"),
  ];

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
                  itemCount: _albums.length,
                  itemBuilder: (context, index) {
                    print(context);
                    print(index);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Photos(album: true,
                            ),
                          ),
                        );
                      },
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                          width: 100.00,
                          height: 100.00,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: ExactAssetImage('img/folderAlbums.png'),
                              fit: BoxFit.fitHeight,
                            ),
                          )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _albums[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color:  Color.fromRGBO(226, 101, 47, 1)
                                ),
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
