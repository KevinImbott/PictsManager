import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/components/ChooseButtons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/Navbar.dart';
import '../components/ProfileInfos.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  late String username;
  late String email ;
  int nbrObject = 17;
  bool buttonChoose = false;

  @override
  void initState() {
    super.initState();
    _loadProfil();
  }

  Future<void> _loadProfil() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';
    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NTY3NzkxNTV9.ICLwkXgJcbyOL2YV8ScR9lixc0YqGzNmIwlsbDxGjXY";
    var url = Uri.parse('http://172.168.1.6:3000/profile');

    await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((response) async {
      if (response.statusCode == 200) {
        print(response.body);
        var data = json.decode(response.body);
        setState(() {
          email = data["email"];
          username = data["pseudo"];
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("img/folderAlbums.png"),
                  //image: NetworkImage("https://pixvisu.files.wordpress.com/2021/01/landscape3.jpg"),
                ),
              ),
            ),
            ProfileInfos(username: (username), email: email),
            ChooseButtonsProfile(),
          ])),
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
    );
  }
}
