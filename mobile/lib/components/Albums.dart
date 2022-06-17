import 'dart:ffi';

import 'package:flutter/material.dart';

class Albums extends StatefulWidget {

  const Albums({Key? key})
      : super(key: key);


  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {

  Widget build(BuildContext context) {
    return
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: const Text("He'd have you all unravel at the"),
            );
  }
}
