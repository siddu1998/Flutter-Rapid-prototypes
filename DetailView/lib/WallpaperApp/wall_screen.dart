import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';



class WallScreen extends StatefulWidget
{
  @override
  _WallScreenState createState()=>new _WallScreenState();
}
class _WallScreenState extends State<WallScreen>
{
  List<DocumentSnapshot> wallpapersList;

  StreamSubscription<QuerySnapshot> subscription;
  final CollectionReference collectionReference = Firestore.instance.collection("wallpapers");

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
      });
    });

    
  }
  
  @override
    void dispose() {
      // TODO: implement dispose
      subscription?.cancel();
      super.dispose();
    }


  @override
  Widget build(BuildContext conntext)
  {
    return new Scaffold(
     appBar: new AppBar(
       title: new Text("Medium"),
     ),
    body: wallpapersList!=null?
    new StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 4,
      itemCount: wallpapersList.length,
      itemBuilder: (context,index)
      {
          String imgPath = wallpapersList[index].data['url'];
          return new Material(
              elevation: 8.0,
              borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
              child: new InkWell(
                child: new Hero(
                  tag: imgPath,
                  child: new FadeInImage(
                    image: new NetworkImage(imgPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

          );
      },
      staggeredTileBuilder: (index)=>new StaggeredTile.count(2,index.isEven?2:3),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    ):new Center(child: new CircularProgressIndicator(),)
    );
  }
}