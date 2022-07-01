import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../components/ImportButton.dart';
import '../components/Navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ScreenHome extends StatefulWidget {
  const ScreenHome({ Key? key }) : super(key: key);
  
  @override
  State<ScreenHome> createState() => _ScreenHome();
}

class _ScreenHome extends State<ScreenHome> {
  late SharedPreferences prefs;
  String token = '';
  late bool hasMore;
  late int pageNumber;
  late bool error;
  late bool loading;
  final int defaultPhotosPerPageCount = 10;
  int nextPageThreshold = 5;  
  late List<Photo> photos;
  late TextEditingController controller;

  @override
  void initState() {
    initPref();
    pageNumber = 1;
    hasMore = true;
    error = false;
    loading = true;
    photos = [];
    super.initState();
    fetchPhotos('');
    controller = TextEditingController();
  }

  Future<String> initPref() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwt') ?? '';
    return token;
  }

 Future<void> fetchPhotos(search) async {
    try {
      Uri url;
      await initPref();
      if (search.isEmpty) {
        nextPageThreshold = 5;
        url = Uri.parse("http://10.0.2.2:3000/home?page=" + pageNumber.toString());
      }
      else {
        nextPageThreshold = -1;
        url = Uri.parse("http://10.0.2.2:3000/home?page=" + pageNumber.toString() + "&name=" + search);
      }
      final response = await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
        },
      );
      List<Photo> fetchedPhotos = Photo.parseList(json.decode(response.body));
      setState(() {
        hasMore = fetchedPhotos.length == defaultPhotosPerPageCount;
        loading = false;
        pageNumber = pageNumber + 1;
        photos.addAll(fetchedPhotos);
      });
    } catch (e) {
      setState(() {
        loading = false;
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
        automaticallyImplyLeading: false,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)
          ),
          child: Center(
            child: TextField(
              controller: controller,
              onChanged: (text) {
                  pageNumber = 1;
                  photos.clear();
                  fetchPhotos(text);
                },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.orange,),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                    photos.clear();
                    pageNumber = 1;
                    fetchPhotos('');
                  },
                  icon: const Icon(Icons.clear, color: Colors.orange,)
                ),
              ),

            ) 
            ),
        ),
      ),
      body: getBody(),
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
    );
  }

  Widget getBody() {
    if (photos.isEmpty) {
      if (loading) {
        return const Center(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (error) {
        return Center(
            child: InkWell(
          onTap: () {
            setState(() {
              loading = true;
              error = false;
              fetchPhotos('');
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Error while loading photos, tap to try agin"),
          ),
        ));
      }
    } else {
      return ListView.builder(
          itemCount: photos.length + (hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (nextPageThreshold != -1 && (index == photos.length - nextPageThreshold)) {
              fetchPhotos('');
            }
            if (index == photos.length) {
              if (error) {
                return Center(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      loading = true;
                      error = false;
                      fetchPhotos('');
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Error while loading photos, tap to try agin"),
                  ),
                ));
              } else {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ));
              }
            }
            final Photo photo = photos[index];
            return Card(
              child: Column(
                children: <Widget>[
                  Image.network(
                    photo.url,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: 210,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(photo.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ],
              ),
            );
          });
    }
    return Container();
  }
}

class Photo {
  int id;
  String name;
  String owner_name;
  String url;
  
  Photo({
    required this.id,
    required this.name,
    required this.owner_name,
    required this.url,
    });
  
  factory Photo.fromJson(Map<String, dynamic> parsedJson) {
    return Photo(
      id: parsedJson['id'],
      name: parsedJson['name'],
      owner_name: parsedJson['owner_name'],
      url: "http://10.0.2.2:3000" + parsedJson['url'],
    );
  }

  static List<Photo> parseList(List<dynamic> list) {
      return list.map((i) => Photo.fromJson(i)).toList();
  }
}