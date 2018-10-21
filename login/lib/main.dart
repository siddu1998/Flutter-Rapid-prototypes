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

class MyHomePage extends StatelessWidget
{


  final FirebaseAuth _auth= FirebaseAuth.instance;
  final GoogleSignIn googleSignIn=new GoogleSignIn();
 


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
              color: Colors.limeAccent,
              child: new Text("Sign In"),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),

            new RaisedButton(
              child:new Text("Sign out"),
              color: Colors.indigoAccent,
              onPressed: _signOut,
            )

          ],
        )
      ),
    );
  }

}