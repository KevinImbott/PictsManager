import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../components/ImportButton.dart';
import '../components/Navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pagination_view/pagination_view.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({ Key? key }) : super(key: key);
  
  @override
  State<ScreenHome> createState() => _ScreenHome();
}

class _ScreenHome extends State<ScreenHome> {
  SharedPreferences? prefs;

  Widget build(BuildContext context) {
    return Scaffold(
      body:  PaginationView<Pic>(
        preloadedItems: <Pic>[
          Pic(faker.person.name(), faker.internet.email()),
          Pic(faker.person.name(), faker.internet.email()),
        ],
        itemBuilder: (BuildContext context, Pic Pic, int index) => ListTile(
          title: Text(user.name),
          subtitle: Text(user.email),
          leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () => null,
          ),
        ),
        header: Text('Header text'),
        footer: Text('Footer text'),
        paginationViewType: PaginationViewType.listView // optional
        pageFetch: pageFetch,
        onError: (dynamic error) => Center(
          child: Text('Some error occured'),
        ),
        onEmpty: Center(
          child: Text('Sorry! This is empty'),
        ),
        bottomLoader: Center( // optional
          child: CircularProgressIndicator(),
        ),
        initialLoader: Center( // optional
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: const Navbar(),
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
    );
  }
}

// Container(
//               margin: const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
//               width: 170,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: const Color.fromRGBO(226, 101, 47, 1)
//                   ),
//                 onPressed: () {

//                 },
//                 child: const Text('Prendre une photo',
//                   style: TextStyle(color: Color.fromRGBO(236, 236, 254, 1) ))
//                 )
//             ),