import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
  }

  navigateToRegister() async {
    Navigator.pushReplacementNamed(context, "SignUp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.greenAccent, Colors.teal],
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),

                height: 350,

                child: Stack(
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/pl.jpeg'),
                        radius: 65.0,
                      ),
                    ),
                    Positioned(
                        bottom: 20,
                        right: 20,
                        child: Text(
                          'COMMUNITY APP',
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 200.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: navigateToLogin,

                      child: Text('LOGIN'),
                      style: ElevatedButton.styleFrom(

                          primary: Colors.teal,

                          textStyle:
                          TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // ignore: deprecated_member_use
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: navigateToRegister,
                      child: Text(
                        'REGISTER',
                      ),
                      style: ElevatedButton.styleFrom(

                          primary: Colors.teal,
                          textStyle:
                          TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              SignInButton(Buttons.Google,
                  text: "Sign up with Google", onPressed: googleSignIn)
            ],
          ),
        ),
      ),
    );
  }
}
