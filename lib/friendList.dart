import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'models/constants.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map data;
  List userData;

  Future getData() async {
    http.Response response = await http.get("https://reqres.in/api/users?page=2");
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[600],
        title: Center(child: Text("FIND Connection... ")),
        actions: [
          Icon(Icons.favorite,
        color: Colors.white,
        size: 24.0,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading:
            CircleAvatar(
              backgroundImage: NetworkImage(userData[index]["avatar"]),
            ),
       title:
       Text("${userData[index]["first_name"]} ${userData[index]["last_name"]}",
         style: fLabelStyle,
         ),
       subtitle:
            Text("${userData[index]["email"]}",
              style: fLabelStyle2,
              ),
          );
        },
      ),
    );
  }
}