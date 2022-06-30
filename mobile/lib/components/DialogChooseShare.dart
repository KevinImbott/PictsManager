
import 'package:flutter/material.dart';

import 'ShareList.dart';

class DialogChooseShare extends StatefulWidget {
  const DialogChooseShare(
      {Key? key, required this.album, required this.picture})
      : super(key: key);

  final String album;
  final String picture;

  @override
  State<DialogChooseShare> createState() => _DialogChooseShare();
}

class _DialogChooseShare extends State<DialogChooseShare> {
  Map<String, bool> _itemsAlbums = {
    'Martin': true,
    'Kevin': false,
    'Manuel': false,
    'Ferrara': true,
    'Abella': false,
    'Bastien': false,
    'Clara': true,
    'Kelly': false,
    'Danger': false,
    'Manon': true,
    'Victoria': false,
    'Tharik': false,
    'Hulk': true,
    'DemonSlayer067': false,
  };
  TextEditingController nameController = TextEditingController();
  String fullName = '';
  bool shareOnlyUser = false;

  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Color.fromRGBO(64, 63, 102, 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              Container(
                  margin: EdgeInsets.all(20),
                  child: SizedBox(
                      width: 250.0,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        onChanged: (text) {
                          setState(() {
                            fullName = text;
                            //fullName = nameController.text;
                          });
                        },
                      ))),
              Container(
                  margin:
                      EdgeInsets.only(top: 25, bottom: 15, right: 4, left: 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(0.0),
                      color: shareOnlyUser == true ? Colors.orange : null,
                      icon: Icon(
                        Icons.supervised_user_circle_rounded,
                        size: 50.0,
                      ),
                      onPressed: () {
                        setState(() {
                          shareOnlyUser = !shareOnlyUser;
                        });
                      },
                    ),
                  )),
            ],
          ),
          ShareList(albums: _itemsAlbums),
          Align(
            alignment: Alignment.centerRight,
            child: RaisedButton.icon(
              color: Color.fromRGBO(226, 101, 47, 1),
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              label: Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
