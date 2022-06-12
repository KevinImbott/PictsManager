import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../components/ImportButton.dart';
import '../components/Navbar.dart';
import 'dart:math';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(children: [
            Stack(children: <Widget>[
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
                  )),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        iconSize: 40.0,
                        icon: Icon(
                          Icons.sensor_door_rounded,
                          color: const Color.fromRGBO(2, 2, 39, 1),
                        ),
                        onPressed: () {})),
              ),
            ]),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Transform.rotate(
                    angle: pi / 1,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("img/Vectortopregister.png"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                        )),
                  ) //Your widget here,
                  ),
            )
          ])),
      bottomNavigationBar: const Navbar(),
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
    );
  }
}
/*
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40.0,
      icon: Icon(
    Icons.sensor_door_rounded,
    color: const Color.fromRGBO(2, 2, 39, 1),
    ),
    onPressed: () {});
  }
}
*/