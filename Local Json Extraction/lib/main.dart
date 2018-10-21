import 'package:flutter/material.dart';

import 'dart:convert';

void main()=>runApp(new MaterialApp(
  theme: new ThemeData(
    primarySwatch: Colors.teal,
  ),
  home:new HomePage(),
));


class HomePage extends StatefulWidget{

  @override 
  HomePageState createState()=>new HomePageState();
}

class HomePageState extends State<HomePage>
{
  List data;
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar:  new AppBar(
        title: new Text("criminal data"),
      ),
  body: new Container(
    child: new Center(
      child: new FutureBuilder(
        future: DefaultAssetBundle
        .of(context)
        .loadString('load_json/person.json'),
        builder: (context,snapshot){
          var mydata=json.decode(snapshot.data.toString());
          return new ListView.builder(
              itemBuilder: (BuildContext context,int index)
              {
                return new Card(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text(mydata[index]['name']),
                        new Text(mydata[index]['age']),
                        new Text(mydata[index]['gender'])
                      ],
                    ),
                );
              },
              itemCount:mydata.length,
          );

        },
      ),
    ),
  ),
    );
  }

}