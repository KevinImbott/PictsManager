import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/components/ChooseButtons.dart';
import '../components/Navbar.dart';
import '../components/ProfileInfos.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

String username = "TanguyPalmie";
String email = "tanguy.palmie@gmail.com";
int nbrObject = 17;
bool buttonChoose = false;

class _Profile extends State<Profile> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(children: [
            Container(
              decoration:  BoxDecoration(
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
