import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List data;
  var json_data=  'Hello';

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Accept": "application/json"
      }
    );
    data = json.decode(response.body);
    print(data[1]["title"]);
    json_data=data[1]["title"];
    
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
    title: new Text('triNetra'),
    backgroundColor: Colors.black,
    ),
  body: new Container(
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        new Text(
                 "output: $json_data",
                 style: new TextStyle(
                   fontSize: 20.0,
                   fontWeight: FontWeight.normal
                 ),
        ),
      new Padding(
        padding: const EdgeInsets.all(8.0),
      ),

       new MaterialButton(
         child: new Text("Where is she?"),
         color: Colors.lightGreenAccent,
         onPressed: getData,
         splashColor: Colors.deepOrange,
       )

      ],
    ),
  ),
  );
}
}