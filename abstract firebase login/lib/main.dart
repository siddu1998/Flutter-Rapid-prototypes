//import 'package:login/WallpaperApp/wall_screen.dart';
//import 'package:login/mlkit/ml_home.dart';

import 'package:flutter/material.dart';
import 'package:login/login_page.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics/observer.dart';
import 'auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override

Widget build(BuildContext context)
{
  return new MaterialApp(
    title: 'Login',
    theme: new ThemeData(
      primarySwatch: Colors.orange,
    ),
    home: new LoginPage(auth: new Auth()),
  );
}

}