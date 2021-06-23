import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'address.dart';
import 'my_shared_preferences.dart';




class Accountpage extends StatefulWidget {
  const Accountpage({Key? key}) : super(key: key);

  @override
  _AccountpageState createState() => _AccountpageState();
}

class _AccountpageState extends State<Accountpage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }
  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser!;
        this.isloggedin = true;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Account'),
        backgroundColor: Colors.teal,

      ),
      body: !isloggedin
          ? CircularProgressIndicator()
          : SingleChildScrollView(
            child: Column(
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
            SizedBox(
              height: 15,
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.person_pin,
                  color: Colors.teal,
                ),
                title: Text(
                  '${user.displayName}',
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontSize: 20.0,


                  ),

                ),
              ),
            ),
            Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: Colors.teal,
                  ),
                  title: Text(
                    '${user.email}',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontSize: 20.0,
                    ),
                  ),
                )
            ),
            ElevatedButton(onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  Addresspage()),
                );
              });
            },
                child: Text('Add Address')),

        SizedBox(height: 30),

        ],
      ),
          ),

    );
  }
}
