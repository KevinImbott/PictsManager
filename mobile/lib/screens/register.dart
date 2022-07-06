import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/screens/ScreenHome.dart';
import 'package:mobile/screens/login.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/Navbar.dart';

String fond = 'img/Fondbleu.png';
String pseudo = '';
String email = '';
String password = '';
bool choix1 = false;
bool choix2 = false;
bool choix3 = false;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void sendLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse('http://54.36.191.51:3000/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'pseudo': pseudo
        }));
    if (response.statusCode == 200) {
      print(json.decode(response.body)['token']);
      await prefs.setString('jwt', json.decode(response.body)['token']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Navbar()));
    } else {
      print(response.statusCode);
      throw Exception('Failed to create USER.');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      return Color.fromRGBO(236, 236, 254, 1);
    }

    return Scaffold(
        backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/Vectortopregister.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.70,
                  child: Center(
                    child: Text(
                      'Inscription',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(236, 236, 254, 1),
                          fontSize: MediaQuery.of(context).size.height * 0.05),
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.70,
                child: TextFormField(
                  style: TextStyle(
                      color: const Color.fromRGBO(236, 236, 254, 1),
                      fontSize: 20.0),
                  onChanged: (val) {
                    setState(() => pseudo = val);
                  },
                  validator: (val) => val!.isEmpty ? 'Pseudo manquant' : null,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    labelStyle: TextStyle(
                        color: const Color.fromRGBO(236, 236, 254, 1),
                        fontSize: MediaQuery.of(context).size.height * 0.020),
                    hintText: 'Pseudo',
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(236, 236, 254, 1)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.70,
                child: TextFormField(
                  style: TextStyle(
                      color: const Color.fromRGBO(236, 236, 254, 1),
                    fontSize: 20.0),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  validator: (val) => val!.isEmpty ? 'Email manquant' : null,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    labelStyle: TextStyle(
                        color: const Color.fromRGBO(236, 236, 254, 1),
                        fontSize: 20.0),
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(236, 236, 254, 1)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.70,
                child: TextFormField(
                  style: TextStyle(
                      fontSize: 20.0,
                    color: fond == 'img/Fondbleu.png'
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0)),
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  validator: (val) => val!.isEmpty ? 'Password manquant' : null,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    labelStyle: TextStyle(
                      color: fond == 'img/Fondbleu.png'
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: 'Mot de passe',
                    hintStyle: TextStyle(
                        color: fond == 'img/Fondbleu.png'
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.70,
                child: TextFormField(
                  style: TextStyle(
                      fontSize: 20.0,
                      color: fond == 'img/Fondbleu.png'
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0)),
                  onChanged: (val) {},
                  validator: (val) => val!.isEmpty ? 'Password manquant' : null,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    labelStyle: TextStyle(
                      color: fond == 'img/Fondbleu.png'
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: 'Confirmer le mot de passe',
                    hintStyle: TextStyle(
                        color: fond == 'img/Fondbleu.png'
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.70,
                 ),
              GestureDetector(
                onTap: () {
                  sendLogin();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.70,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 226, 101, 1),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      'Inscription',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: MediaQuery.of(context).size.height * 0.025),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyLoginPage()));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Center(
                    child: Text(
                      'Déjà un compte ?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: MediaQuery.of(context).size.height * 0.025),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/Vectorbot.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
