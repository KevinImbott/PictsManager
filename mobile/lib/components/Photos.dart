import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/screens/ShowPicture.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'DialogAlbumOrShare.dart';
import 'Navbar.dart';

class PhotoItem {
  final String id;
  final String image;

  PhotoItem(this.id, this.image);
}

class Photos extends StatefulWidget {
  const Photos({Key? key, required this.album}) : super(key: key);
  final String album;

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  String get album => widget.album;

  List TheListPictures = [];
  List<PhotoItem> _itemsFolder = [PhotoItem('0', "https://i.ibb.co/N3fg5JQ/Back-Folder.png" )];
  List _items = [];



  Future<void> _loadPhotos() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';

    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE2NTc0NjYzMDV9.zc7UkDGzNgNwNt5dIU5tYfQcOX7z1GNfnAAXxDGH8gA";
    var url = Uri.parse('http://172.168.1.6:3000/pictures');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) async {
      if (response.statusCode == 200) {
        var tagsJson = jsonDecode(response.body);
        List tags = List.from(tagsJson);
        print(tags);
        for (int i = 0; i < tags.length; i++) {
          setState(() {
            _items.add(PhotoItem(tags[i]["id"].toString(),"http://172.168.1.6:3000/"+tags[i]["url"]));
          });
        }
      }
    });
  }

  Future<void> _loadPhotosAlbumId(albumId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';

    token =
    "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE2NTc0NjYzMDV9.zc7UkDGzNgNwNt5dIU5tYfQcOX7z1GNfnAAXxDGH8gA";
    var url = Uri.parse('http://172.168.1.6:3000/albums/'+albumId);
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) async {
      if (response.statusCode == 200) {
        var tagsJson = jsonDecode(response.body);
        tagsJson=tagsJson["pictures"];
        List tags = List.from(tagsJson);
        print(tags);
        for (int i = 0; i < tags.length; i++) {
          setState(() {
            _items.add(PhotoItem(tags[i]["id"].toString(),"http://172.168.1.6:3000/"+tags[i]["url"]));
          });
        }
      }
    });
  }

  @override
  initState() {
    super.initState();

    print("album");
    print(album);
    print("album");
    if(album=="") {
      print("baisetes morts");
      _loadPhotos();
    }else{
      print("coucou");
      _loadPhotosAlbumId(album);
    }
  }

  Widget build(BuildContext context) {

    if (album != "") {
      TheListPictures = [..._itemsFolder, ..._items];
    } else {
      TheListPictures = [..._items];
    }
    print(TheListPictures);



    return SizedBox(
        height: MediaQuery.of(context).size.height, // Some height
        child: Column(children: [
          Flexible(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 3,
                  ),
                  itemCount: TheListPictures.length,
                  itemBuilder: (context, index) {
                    print(context);
                    print(index);

                    return GestureDetector(
                      onTap: () {
                        if (index == 0 && album != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Navbar(
                                        index: 2,
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowPicture(
                                  image: TheListPictures[index].image,
                                  id: TheListPictures[index].id,
                                ),
                              ));
                        }
                      },
                      onLongPress: () => showDialog(
                          context: context,
                          builder: (context) => DialogAlbumOrShare(pictureId: TheListPictures[index].id,albumsId: "",)
                      ),
                      child:
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(2, 2, 39, 1),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(TheListPictures[index].image),
                          ),
                        ),
                      )
                    );
                  }))
        ]));
  }
}
