import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/components/AlbumsList.dart';
import 'package:mobile/screens/ShowPicture.dart';
import 'package:mobile/screens/profile.dart';


class DialogChooseAlbums extends StatefulWidget {

  const DialogChooseAlbums({Key? key, required this.albumsId}) : super(key: key);
  final String albumsId;

  @override
  State<DialogChooseAlbums> createState() => _DialogChooseAlbums();
}

class _DialogChooseAlbums extends State<DialogChooseAlbums> {
  Map<String, bool> _itemsAlbums = {
    'Main': true,
    'Summer': false,
    'Picture': false,
  };
  String get albumsId => widget.albumsId;


  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromRGBO(64, 63, 102, 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15,),
          Text('Placer dans un album', style: TextStyle(
              color: Color.fromRGBO(226, 101, 47, 1),
        fontSize: MediaQuery.of(context).size.height * 0.04),
    ),
          AlbumsList(albums: _itemsAlbums),
          Align(
            alignment: Alignment.centerRight,
            child:Container(
              margin: const EdgeInsets.only(right: 10.0),
              child:RaisedButton.icon(
              color: Color.fromRGBO(226, 101, 47, 1),
              icon: Icon(Icons.close,  color: Colors.white,
              ),
              label: Text('Close', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),),
          )
        ],
      ),
    );
  }}