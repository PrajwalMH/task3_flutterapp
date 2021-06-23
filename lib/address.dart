import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task3_flutterapp/Login.dart';
import 'package:task3_flutterapp/account.dart';
import 'package:task3_flutterapp/add.dart';
import 'package:task3_flutterapp/profile.dart';

import 'my_shared_preferences.dart';
class Addresspage extends StatefulWidget {
  const Addresspage({Key? key}) : super(key: key);

  @override
  _AddresspageState createState() => _AddresspageState();
}

class _AddresspageState extends State<Addresspage> {

  bool isLoggedIn = false;


  Addresspage() {
    MySharedPreferences.instance
        .getBooleanValue("loggedin")
        .then((value) => setState(() {
      isLoggedIn = value;
    }));
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: isLoggedIn ? Profile() : Add());


  }
}



