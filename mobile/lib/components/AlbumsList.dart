import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile/screens/ShowPicture.dart';
import 'package:mobile/screens/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AlbumsShow {
  final String id;
  final String name;
  late final bool checked;

  AlbumsShow(this.id, this.name, this.checked);
}

class AlbumsList extends StatefulWidget {
  const AlbumsList({Key? key, required this.albums}) : super(key: key);
  final List<AlbumsShow> albums;

  @override
  State<AlbumsList> createState() => _AlbumsList();
}

class _AlbumsList extends State<AlbumsList> {
  List<AlbumsShow> get albums => widget.albums;

  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    //_feedCheckLoad
    _isChecked = List<bool>.filled(albums.length, false);
  }

  void _updateCHeckbox(id) {
    print("----------------------");
    print(id);
    print("============");
  }


  Widget build(BuildContext context) {
    print(context);
    return Flexible(
      child: _buildList()
    );
  }
/*
  Widget _buildList() {
    return Text("data");
  }*/
    Widget _buildList() {
    return  ListView(
      children:  albums.map((albumIndex) {
        print("albumIndex");
        print(albumIndex.id);
        print("albumIndex");
        return CheckboxListTile(
          tileColor: albumIndex.checked==true?Color.fromRGBO(226, 101, 47, 0.75):null,
          secondary:  Icon(Icons.folder_copy, color: albumIndex.checked==false?Color.fromRGBO(226, 101, 47, 1):Colors.white),
          title: Text(albumIndex.name, style: TextStyle(color: Colors.white),),
          activeColor:Colors.white,
          checkColor: Color.fromRGBO(226, 101, 47, 1),
          side: albumIndex.checked==true?BorderSide(width: 16.0, color: Colors.lightBlue.shade50):BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
          value: albumIndex.checked,

          onChanged: (bool? value) {
            setState(() {
              _updateCHeckbox(albumIndex.id);
              albumIndex.checked = value!;
              print("updatethis");
            });
          },
        );
      }).toList(),
    );
  }
}
