import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/screens/login.dart';
import 'package:mobile/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Navbar.dart';

class ProfileInfos extends StatefulWidget {
  const ProfileInfos({Key? key, required this.username, required this.email})
      : super(key: key);
  final String username;
  final String email;

  @override
  State<ProfileInfos> createState() => _ProfileInfosState();
}

class _ProfileInfosState extends State<ProfileInfos> {
  String get username => widget.username;
  String get email => widget.email;
  String get initial => widget.username.substring(0, 2).toUpperCase();
  String usernameUpdate = "";
  String emailUpdate = "";
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadProfil() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwt') ?? '';

    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NTY3NzkxNTV9.ICLwkXgJcbyOL2YV8ScR9lixc0YqGzNmIwlsbDxGjXY";
    var url = Uri.parse('http://172.168.1.6:3000/profile');
    await http
        .put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'email': emailUpdate != null ? emailController.text : emailUpdate,
        'pseudo': usernameUpdate != null ? usernameController.text : usernameUpdate,
        'password': "password",
      }),
    )
        .then((response) async {
      print(response.statusCode);
      if (response.statusCode == 204) {
        Navigator.push(
           context, MaterialPageRoute(builder: (context) => Navbar(index: 2)));
      }
    });
  }

  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: <Widget>[
          Container(
            height: 160.00,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/VectorProfile.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            top: 25,
            right: 0,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    iconSize: 40.0,
                    icon: Icon(
                      Icons.sensor_door_rounded,
                      color: const Color.fromRGBO(2, 2, 39, 1),
                    ),
                    onPressed: () {
                      _disconnectDialog(context);
                    })),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: CircleAvatar(
              radius: 46,
              backgroundColor: Color.fromRGBO(226, 101, 47, 1),
              child: Text(
                initial,
                style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.black // insert your font size here
                    ),
              ),
            ), //CircularAvatar
          ),
          Positioned(
              height: 200,
              top: 68,
              left: 120,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      username != null ? username : "Not defined",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: const Color.fromRGBO(226, 101, 47, 1),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 5),
                    Text(
                      email != null ? email : "Not defined",
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                    TextButton(
                      child: Text("MODIFIER".toUpperCase(),
                          style: TextStyle(fontSize: 10)),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.only(right: 35, left: 35)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.white)))),
                      onPressed: () {
                        _changeUserDialog(context, username,email);
                      },
                    )
                  ])) //Positioned
        ],
      ),
    ]);
  }

  void _disconnectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(64, 63, 102, 1),
          title: new Text(
            "Déconnexion",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "Voulez-vous vous déconnecter?",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [new FlatButton(
                  child: new Text(
                    "Annuler",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                  new FlatButton(
                    color: Colors.orange,
                    child: new Text("Déconnexion", style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),]
            )
          ],
        );
      },
    );
  }

  void _changeUserDialog(BuildContext context, username, email) {
    print(username);
    usernameController.text = username;
    emailController.text = email;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(64, 63, 102, 1),
          title: new Text(
            "Modifier",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Theme(
              data: ThemeData(
                  textSelectionTheme:
                      TextSelectionThemeData(selectionColor: Colors.orange)),
              child: TextField(
                cursorColor: Colors.orange,
                style: TextStyle(color: Colors.white),
                controller: usernameController,
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Uername',
                    labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text) {
                  setState(() {
                    usernameUpdate = usernameController.text;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            TextField(
              cursorColor: Colors.orange,
              style: TextStyle(color: Colors.white),
              controller: emailController,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orange),
                ),
                border: OutlineInputBorder(),
                labelText: 'Email ',
                labelStyle: TextStyle(color: Colors.white),
              ),
              onChanged: (text) {
                setState(() {
                  emailUpdate = emailController.text;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  child: new Text("Annuler",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  color: Colors.orange,
                  child: new Text(
                    "Sauvegarder",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _loadProfil();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
