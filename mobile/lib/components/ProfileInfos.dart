import 'package:flutter/material.dart';

import 'Albums.dart';

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
                    onPressed: () {})),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: CircleAvatar(
              radius: 46,
              backgroundColor: Colors.orange.shade700,
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
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.white)))),
                        onPressed: () => null),
                  ])) //Positioned
        ],
      ),
    ]);
  }
}
