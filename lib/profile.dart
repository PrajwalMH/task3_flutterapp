import 'package:flutter/material.dart';
import 'package:task3_flutterapp/HomePage.dart';
import 'package:task3_flutterapp/account.dart';
import 'my_shared_preferences.dart';
import 'Add.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  String landmark = "";
  String city = "";
  String state = "";

  ProfileState() {
    MySharedPreferences.instance
        .getStringValue("landmark")
        .then((value) => setState(() {
      landmark = value;
    }));
    MySharedPreferences.instance
        .getStringValue("city")
        .then((value) => setState(() {
      city = value;
    }));
    MySharedPreferences.instance
        .getStringValue("state")
        .then((value) => setState(() {
      state = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/mn.png'),
                  radius: 70,
                ),
              ),
              Text(
                "Address Added " ,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Text(
                landmark,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                city,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                state,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 80),
              SizedBox(
                width: 150,
                height: 50,
                // ignore: deprecated_member_use
                child: RaisedButton(
                    color: Colors.grey,
                    child: Text("Home",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () {
                      MySharedPreferences.instance.removeAll();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => HomePage()));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}