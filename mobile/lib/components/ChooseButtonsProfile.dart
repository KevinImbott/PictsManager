import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile/components/Photos.dart';

import 'Albums.dart';
import 'package:http/http.dart' as http;

class ChooseButtonsProfile extends StatefulWidget {

  const ChooseButtonsProfile({Key? key})
      : super(key: key);


  @override
  State<ChooseButtonsProfile> createState() => _ChooseButtonsProfileState();
}

class _ChooseButtonsProfileState extends State<ChooseButtonsProfile> {
  bool select = false;

  Widget build(BuildContext context) {
    return
      Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text('Album'),
                onPressed: () {
                  setState(() {
                    select=false;
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: select==false?Colors.orange.shade700:Colors.transparent,
                    padding: EdgeInsets.only(left: 50, right: 50),
                    textStyle: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                child: Text('Photos'),
                onPressed: () {
                  setState(() {
                  select=true;
                });
                },
                style: ElevatedButton.styleFrom(
                    primary: select==true?Colors.orange.shade700:Colors.transparent,
                    padding: EdgeInsets.only(left: 50, right: 50),

                    textStyle: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),

              ),
            ]),
        Container(child:
        Divider(
          height: 10,
          color: Colors.orange.shade700,
          thickness: 10,
          indent: 20,
          endIndent: 20,
        ),
        ),
        SizedBox(height: 5),

        select==false?Albums(album: !select,):Photos(album: !select)
      ],
      );
  }
}
