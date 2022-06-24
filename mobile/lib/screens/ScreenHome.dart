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
  late int page;
  late PaginationViewType paginationViewType;
  late GlobalKey<PaginationViewState> key;

  @override
  void initState() {
    page = -1;
    paginationViewType = PaginationViewType.listView;
    key = GlobalKey<PaginationViewState>();
    super.initState();
  }

  Future<List<Pic>> pageFetch(int offset) async {
    print(offset);
    page = (offset / 20).round();
    final Faker faker = Faker();
    final List<Pic> nextPicsList = List.generate(
      20,
      (int index) => Pic(
        faker.person.name() + ' - $page$index',
        faker.internet.email(),
      ),
    );
    await Future<List<Pic>>.delayed(Duration(seconds: 1));
    return page == 5 ? [] : nextPicsList;
  }

  @override
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
      backgroundColor: const Color.fromRGBO(2, 2, 39, 1),
    );
  }
}
