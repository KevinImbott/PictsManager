import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Styling Demo';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: HELLO(),
        body: const MyCustomForm(),
      ),
    );
  }
}

HELLO() {}


class MyCustomForm extends StatelessWidget {
  const MyCustomForm({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Pseudo',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Password',
              
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Confirm Password',
            ),
            onChanged: (value) {
              if (getPasswordStrength(value!) < 1) {
                return 'Not a valid password';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }



getPasswordStrength(String password) {
  if (password.isEmpty) return 0;
  double pFraction;
  if (RegExp(r'^[0-9]*$').hasMatch(password)) {
    pFraction = 0.8;
  } else if (RegExp(r'^[a-zA-z0-9]*$').hasMatch(password)) {
    pFraction = 1.5;
  } else if (RegExp(r'^[a-z]*$').hasMatch(password)) {
    pFraction = 1.0;
  } else if (RegExp(r'^[a-zA-z]*$').hasMatch(password)) {
    pFraction = 1.3;
  } else if (RegExp(r'^[a-z\- !?]*$').hasMatch(password)) {
    pFraction = 1.3;
  } else if (RegExp(r'^[a-z0-9]*$').hasMatch(password)) {
    pFraction = 1.2;
  } else {
    pFraction = 1.8;
  }
  // ignore: prefer_function_declarations_over_variables
  var logF = (double x) {
    return 1.0 / (1.0 + exp(-x));
  };
  // ignore: prefer_function_declarations_over_variables
  var logC = (double x) {
    return logF((x / 2.0) - 4.0);
  };

  var pStrength = logC(password.length * pFraction);

  return pStrength;
}


}
