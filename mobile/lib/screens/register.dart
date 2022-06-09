import 'package:flutter/material.dart';
import 'package:mobile/screens/login.dart';

void main() => runApp(const MyApp());

String pseudo = '';
String email = '';
String password = '';
bool choix1 = false;
bool choix2 = false;
bool choix3 = false;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OSWALD'
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
 
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
    backgroundColor: const Color.fromRGBO(2, 2,39 , 1),
      body:Container(
          height: double.infinity,
          width: double.infinity,
          
          child: Column(children: [
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
              height:MediaQuery.of(context).size.height *0.15,
              width:MediaQuery.of(context).size.height*0.70,
              child:Center(
                child: Text('Inscriptions',style: TextStyle(fontWeight:FontWeight.bold,color:Color.fromRGBO(236, 236, 254, 1),fontSize: MediaQuery.of(context).size.height *0.05),),
              )
            ),SizedBox(
               height:MediaQuery.of(context).size.height *0.05,
              width:MediaQuery.of(context).size.width *0.60,
              child:TextFormField(
              style: TextStyle(color:const Color.fromRGBO(236, 236, 254, 1),fontSize: MediaQuery.of(context).size.height *0.020),
              onChanged: (val){
                    setState(()=>pseudo = val);
                  },
                  validator:(val) =>
                  val!.isEmpty ? 'Email manquant' : null,
                  
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color:const Color.fromRGBO(236, 236, 254, 1),fontSize: MediaQuery.of(context).size.height *0.020),
                    hintText: 'Pseudo',
                    hintStyle: const TextStyle(color: Color.fromRGBO(236, 236, 254, 1)),
                  ),
              ),
            ),
            SizedBox(
               height:MediaQuery.of(context).size.height *0.05,
              width:MediaQuery.of(context).size.width *0.60,
              child:TextFormField(
                style: TextStyle(color:const Color.fromRGBO(236, 236, 254, 1),fontSize: MediaQuery.of(context).size.height *0.020),
                onChanged: (val){
                  setState(()=>email = val);
                },
                validator:(val) =>
                val!.isEmpty ? 'Email manquant' : null,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color:const Color.fromRGBO(236, 236, 254, 1),fontSize: MediaQuery.of(context).size.height *0.020),
                    hintText: 'Email',
                  hintStyle: const TextStyle(color: Color.fromRGBO(236, 236, 254, 1)),
                  ),
                ),
            ),
    SizedBox(
               height:MediaQuery.of(context).size.height *0.05,
              width:MediaQuery.of(context).size.width *0.60,
              child: TextFormField(
                style: TextStyle(
                    color: const Color.fromRGBO(236, 236, 254, 1),
                    fontSize: MediaQuery.of(context).size.height * 0.020),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
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
               height:MediaQuery.of(context).size.height *0.05,
              width:MediaQuery.of(context).size.width *0.60,
              child: TextFormField(
                style: TextStyle(
                    color: const Color.fromRGBO(236, 236, 254, 1),
                    fontSize: MediaQuery.of(context).size.height * 0.020),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                onChanged: (val) {
                  setState(() => password = val);
                },
                validator: (val) => val!.isEmpty ? 'password is not identical' : null,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: const Color.fromRGBO(236, 236, 254, 1),
                      fontSize: MediaQuery.of(context).size.height * 0.020),
                  hintText: 'Password confirm',
                  hintStyle:
                      const TextStyle(color: Color.fromRGBO(236, 236, 254, 1)),
                ),
              ),
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height *0.10,
              width:MediaQuery.of(context).size.height *0.70,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[                 
            Container(
              height:MediaQuery.of(context).size.height *0.08,
              width:MediaQuery.of(context).size.height *0.08,
              decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/google.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
            ),
            Container(
              height:MediaQuery.of(context).size.height *0.08,
              width:MediaQuery.of(context).size.height *0.08,
              decoration: const BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("img/facebook.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
            ),
                ]
              )
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
            GestureDetector(
              onTap: (){},
              child: Container(
                height:MediaQuery.of(context).size.height *0.05,
                width:MediaQuery.of(context).size.width *0.70,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 226, 101, 1),
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Center(
                  child: Text('Inscription',style: TextStyle(color:Color.fromARGB(255, 255, 255, 255),fontSize: MediaQuery.of(context).size.height *0.025),),
                ),
              ),
            ),
            TextButton(onPressed: (){
              Navigator.push(context,
                            MaterialPageRoute<void>(
                                builder:(BuildContext context) {
                                  return MyLoginPage();
                                }));
            }, child: Text('Deja un compte',style: TextStyle(color:Color.fromARGB(255, 255, 255, 255),fontSize: MediaQuery.of(context).size.height *0.015),))
          ,
          SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
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
      )
    );
  }
}