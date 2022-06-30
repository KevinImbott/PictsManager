import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShareList extends StatefulWidget {
  const ShareList({Key? key, required this.albums}) : super(key: key);
  final Map<String, bool> albums;

  @override
  State<ShareList> createState() => _ShareList();
}

class _ShareList extends State<ShareList> {
  Map<String, bool> get albums => widget.albums;

  @override
  void initState() {
    super.initState();
    // _feedCheckLoad();
  }

  Future<void> _saveDB() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('jwt') ?? '';
    } catch (e) {
      print(e);
    }
  }

  /*Future<void> _feedCheckLoad() async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('jwt') ?? '';

    var uri = Uri.parse('http://90.26.100.130:70/actualities/get_preferences');

    var req = http.MultipartRequest('GET', uri);
    req.headers['Authorization'] = 'Bearer ' + token;
    req.send().then((response) {
      if (response.statusCode == 200) {
        //var success = json.decode(response);
        print(response);
        setState(() {
          albums=[variable];
        });
      }
      else {
        print(response.toString());
      }
    }).catchError((onError) {
      print(onError);
    });
  }*/
  void itemChange(val, int index) {
    print("============");
    print(val);
    print(index);
    print("============");
  }

  Widget build(BuildContext context) {
    print(context);
    return _buildList();
  }

  Widget _buildList() {
    return Container(
        height: 400,
        child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              children: albums.keys.map((String key) {
                return CheckboxListTile(
                  tileColor: albums[key] == true
                      ? Color.fromRGBO(226, 101, 47, 0.75)
                      : null,
                  secondary: Icon(Icons.account_circle,
                      color: albums[key] == false
                          ? Color.fromRGBO(226, 101, 47, 1)
                          : Colors.white),
                  title: Text(
                    key,
                    style: TextStyle(color: Colors.white),
                  ),
                  activeColor: Colors.white,
                  checkColor: Color.fromRGBO(226, 101, 47, 1),
                  side: albums[key] == true
                      ? BorderSide(width: 16.0, color: Colors.lightBlue.shade50)
                      : BorderSide(
                          width: 16.0, color: Colors.lightBlue.shade50),
                  value: albums[key],
                  onChanged: (bool? value) {
                    setState(() {
                      albums[key] = value!;
                    });
                  },
                );
              }).toList(),
            )));
  }
}
