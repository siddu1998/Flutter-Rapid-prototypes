import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';





void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ) ,
      home:new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget
{

  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {

  String myText=null;
  final DocumentReference documentReference = Firestore.instance.document("myData/dummy");

  final FirebaseAuth _auth= FirebaseAuth.instance;
  final GoogleSignIn googleSignIn=new GoogleSignIn();
  StreamSubscription<DocumentSnapshot> subscription;
  

  Future<FirebaseUser> _signIn() async  {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA=await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: gSA.idToken,
      accessToken: gSA.accessToken
    );
    print("Hey ${user.displayName}");
    return user;
  }

  void _signOut()
  {
    googleSignIn.signOut();
    print("user signed out");
  }

 void _add() {
    Map<String, String> data = <String, String>{
      "name": "Pawan Kumar",
      "desc": "Flutter Developer"
    };
    documentReference.setData(data).whenComplete(() {
      print("Document Added");
    }).catchError((e) => print(e));
  }
  void _delete(){
    documentReference.delete().whenComplete((){
            print("Deleted");
            setState(() {});
    }).catchError((e)=>print(e));
  }
  void _update(){
    Map<String, String> data = <String, String>{
      "name": "Sai Siddartha Maram",
      "desc": "Machine Learning"
    };
    documentReference.updateData(data).whenComplete(() {
      print("Document updated");
    }).catchError((e) => print(e));
  }
    void _fetch() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          myText = datasnapshot.data['desc'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = documentReference.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          myText = datasnapshot.data['desc'];
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }
  @override 
  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Firebase Demo"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

          

            new RaisedButton(
              onPressed: ()=>_signIn().then((FirebaseUser user)=>print(user)).catchError((e)=>print(e)),
              color: Colors.green,
              child: new Text("Sign In"),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),

            new RaisedButton(
              child:new Text("Sign out"),
              color: Colors.indigoAccent,
              onPressed: _signOut,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),


            new RaisedButton(
              child:new Text("Add"),
              color: Colors.purpleAccent,
              onPressed: _add,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),


            new RaisedButton(
              child:new Text("Update"),
              color: Colors.lightGreenAccent,
              onPressed: _update,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),


            new RaisedButton(
              child:new Text("Delete"),
              color: Colors.redAccent,
              onPressed: _delete,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),


            new RaisedButton(
              child:new Text("Fetch"),
              color: Colors.deepPurpleAccent,
              onPressed: _fetch,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
          myText==null?new Container():new Text(myText,
                                                style:new TextStyle(fontSize:20.0)),
          ],
        )
      ),
    );
  }
}