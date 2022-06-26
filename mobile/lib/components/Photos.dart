import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/components/DialogChooseAlbums.dart';
import 'package:mobile/screens/ShowPicture.dart';
import 'package:mobile/screens/profile.dart';

import 'DialogAlbumOrShare.dart';
import 'Navbar.dart';

class PhotoItem {
  final String image;
  final String name;
  final String description;
  PhotoItem(this.image, this.name, this.description);
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
    PhotoItem("https://i.ibb.co/N3fg5JQ/Back-Folder.png", "Album Back","")
  ];
  List<PhotoItem> _items = [
    PhotoItem(
        "https://random.imagecdn.app/500/150",
        "Liam Gant",
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anythi"
    ),    PhotoItem(
        "https://random.imagecdn.app/500/150",
        "Liam Gant",
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anythi"
    ),    PhotoItem(
        "https://random.imagecdn.app/500/150",
        "Liam Gant",
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anythi"
    ),    PhotoItem(
        "https://random.imagecdn.app/500/150",
        "Liam Gant",
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anythi"
    ),

  ];

  @override
  initState() {
    super.initState();
    if (album == true) {
      TheListPictures = [..._itemsFolder, ..._items];
    } else {
      TheListPictures = [..._items];
    }
    print(TheListPictures);
  }

  Widget build(BuildContext context) {
    print(album);
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
                  itemCount: _items.length,
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
                                      name: TheListPictures[index].name,
                                      description: TheListPictures[index].description),
                                ),
                              );
                            }
                          },
                          onLongPress: () {
                            print("Add albums");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DialogAlbumOrShare()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(2, 2, 39, 1),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(TheListPictures[index].image),
                              ),
                            ),
                          ),
                    );
                  }))
        ]));
  }
}

