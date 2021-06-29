import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httptest20/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Utils _utils = new Utils();
  var data;
  @override
  void initState() {
    super.initState();
    getPersonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Fractalite app'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(data[index]['name']),
                    trailing: Text(data[index]['id'].toString()),
                  ),
                  // ListTile(
                  //   title: Text(data[index]['mainEmail']['address']),
                  //   trailing: Text(data[index]['country']['name']),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  getPersonData() async {
    var response = await http.get(Uri.parse(_utils.apiBaseurl + "persons"));
    var result = json.decode(response.body);
    setState(() {
      data = result["content"];
    });
    print(data);
  }
}
