import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile/screens/ShowPicture.dart';
import 'package:mobile/screens/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AlbumsList extends StatefulWidget {
  const AlbumsList({Key? key, required this.albums}) : super(key: key);
  final Map<String, bool> albums;

  @override
  State<AlbumsList> createState() => _AlbumsList();
}

class _AlbumsList extends State<AlbumsList> {
  Map<String, bool> get albums => widget.albums;

  @override
  void initState() {
    super.initState();
   // _feedCheckLoad();
  }

  Future<void> _saveDB() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwt') ?? '';

    } catch (e) {
      print(e);
    }
  }

  /*Future<void> _feedCheckLoad() async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('jwt') ?? '';

    var uri = Uri.parse('http://90.26.100.130:70/actualities/get_preferences');

    var req = http.MultipartRequest('GET', uri);
    req.headers['Authorization'] = 'Bearer ' + token;
    req.send().then((response) {
      if (response.statusCode == 200) {
        //var success = json.decode(response);
        print(response);
        setState(() {
          albums=[variable];
        });
      }
      else {
        print(response.toString());
      }
    }).catchError((onError) {
      print(onError);
    });
  }*/
  void itemChange(val, int index) {
    print("============");
    print(val);
    print(index);
    print("============");
  }


  Widget build(BuildContext context) {
    print(context);
    return Flexible(
      child: _buildList()
    );
  }

  Widget _buildList() {
    return new ListView(
      children:  albums.keys.map((String key) {
        return CheckboxListTile(
          tileColor:albums[key]==true?Color.fromRGBO(226, 101, 47, 0.75):null,
          secondary:  Icon(Icons.folder_copy, color: albums[key]==false?Color.fromRGBO(226, 101, 47, 1):Colors.white),
          title: new Text(key, style: TextStyle(color: Colors.white),),
          activeColor:Colors.white,
          checkColor: Color.fromRGBO(226, 101, 47, 1),
          side: albums[key]==true?BorderSide(width: 16.0, color: Colors.lightBlue.shade50):BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
          value: albums[key],

          onChanged: (bool? value) {
            setState(() {
              albums[key] = value!;
            });
          },
        );
      }).toList(),
    );
  }
}
