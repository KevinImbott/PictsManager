import 'package:flutter/material.dart';
import 'package:path/path.dart';

void main() => runApp(const MyApp());
String fond = 'img/Fondbleu.png';
String pseudo = '';
String email = '';
String password = '';
bool choix1 = false;


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyLoginPage({Key? key});
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
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
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 0, 0, 0).withOpacity(0.5), BlendMode.dstATop),
                  fit: BoxFit.cover,
                  image: AssetImage(fond))),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              height: MediaQuery.of(context).size.height * 0.025,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height * 0.70,
                child: Center(
                  child: Text(
                    'Connection',
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
                    fontSize: MediaQuery.of(context).size.height * 0.020),
                onChanged: (val) {
                  setState(() => email = val);
                },
                validator: (val) => val!.isEmpty ? 'Email manquant' : null,
                decoration: InputDecoration(
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
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.70,
              child: TextFormField(
                style: TextStyle(
                    color: const Color.fromRGBO(236, 236, 254, 1),
                    fontSize: MediaQuery.of(context).size.height * 0.020),
                onChanged: (val) {
                  setState(() => password = val);
                },
                validator: (val) => val!.isEmpty ? 'Password manquant' : null,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: const Color.fromRGBO(236, 236, 254, 1),
                      fontSize: MediaQuery.of(context).size.height * 0.020),
                  hintText: 'Password',
                  hintStyle:
                      const TextStyle(color: Color.fromRGBO(236, 236, 254, 1)),
                ),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.height
            ),
            Row(
              children: [
                Checkbox(
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  onChanged: (bool? value) {
                    setState(() {
                      choix1 = !choix1;
                    });
                  },
                  value: choix1,
                ),
                const Text('Se souvenir de moi.',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
              ],
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.height * 0.70,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.height * 0.08,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("img/google.png"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.height * 0.08,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage("img/facebook.png"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ])),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height),
            GestureDetector(
              onTap: () {},
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
          ]),
        ));
  }
}
