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
  final bool album;

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  bool get album => widget.album;

  List<PhotoItem> TheListPictures = [];
  List<PhotoItem> _itemsFolder = [
    PhotoItem("0", "https://i.ibb.co/N3fg5JQ/Back-Folder.png")
  ];

  List<PhotoItem> _items = [
    PhotoItem(
      "0",
      "https://random.imagecdn.app/500/150",
    )
  ];

  Future<void> _loadPhotos() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';

    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NTY3NzkxNTV9.ICLwkXgJcbyOL2YV8ScR9lixc0YqGzNmIwlsbDxGjXY";
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
//            _items.add(PhotoItem(tags[i]["id"].toString(),tags[i]["url"]));
            _items.add(PhotoItem(tags[i]["id"].toString(),
                "https://images-na.ssl-images-amazon.com/images/I/51igunD6VmL._SX353_BO1,204,203,200_.jpg"));
          });
        }
      }
    });
  }

  @override
  initState() {
    super.initState();
    _loadPhotos();
    print("_items");
    print(_items[0]);
    print(_itemsFolder);
    print("_items");

    if (album == true) {
      TheListPictures = [..._itemsFolder, ..._items];
    } else {
      TheListPictures = [..._items];
    }
    print(TheListPictures.length);
  }

  Widget build(BuildContext context) {
    print(TheListPictures.length);

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
                        if (index == 0 && album == true) {
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(2, 2, 39, 1),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(TheListPictures[index].image),
                          ),
                        ),
                      ),
                    );
                  }))
        ]));
  }
}
