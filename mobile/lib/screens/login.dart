import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/components/Navbar.dart';
import 'package:mobile/screens/ScreenHome.dart';
import 'package:mobile/screens/register.dart';
import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String fond = 'img/Fondbleu.png';
String pseudo = '';
String email = '';
String password = '';
bool choix1 = false;

class Login extends StatelessWidget {
  Login({Key? key, this.token}) : super(key: key);
  final String? token;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'OSWALD'),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key? key, this.token});
  String? token;
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  void sendLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse('http://10.0.2.2:3000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));
    if (response.statusCode == 200) {
      //print(json.decode(response.body)['token']);
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
      return const Color.fromRGBO(236, 236, 254, 1);
    }

    return Scaffold(
        backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(children: [
          /*  ElevatedButton(
              child: Text('HomePage'),
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Navbar()));
                });
              },
            ),*/
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/Vector.png"),
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
                    'Connection',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(236, 236, 254, 1),
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
                      fontSize: MediaQuery.of(context).size.height * 0.020),
                  hintText: 'Email',
                  hintStyle:
                      const TextStyle(color: Color.fromRGBO(236, 236, 254, 1)),
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
                  fontSize: 20.0,
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
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
                      color: const Color.fromRGBO(236, 236, 254, 1),
                      fontSize: MediaQuery.of(context).size.height * 0.020),
                  hintText: 'Password',
                  hintStyle:
                      const TextStyle(color: Color.fromRGBO(236, 236, 254, 1)),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.height),

            SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.height * 0.70,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height),
            GestureDetector(
              onTap: () {
                sendLogin();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 226, 101, 1),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Text(
                    'Connection',
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
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.75,
                child: Center(
                  child: Text(
                    'Pas de compte ?',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: MediaQuery.of(context).size.height * 0.025),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.17,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/Vectorbot.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ]),
        ));
  }
}
