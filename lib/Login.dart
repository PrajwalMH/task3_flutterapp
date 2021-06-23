import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {


        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
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
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100))),

              height: 350,

              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 20,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, "/");
                            }),
                        Text(
                          'Back',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/ff.jpg'),
                      radius: 65.0,
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      right: 20,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            Container(

              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.email), onPressed: null),
                          Expanded(
                            child: Container(
                              child: TextFormField(
                                  validator: (input) {
                                    if (input!.isEmpty) return 'Enter Email';
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Email', ),
                                  onSaved: (input) => _email = input!),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.lock), onPressed: null),
                          Expanded(
                            child: Container(
                              child: TextFormField(
                                  validator: (input) {
                                    if (input!.length < 6)
                                      return 'Provide Minimum 6 Character';
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Password',

                                  ),
                                  obscureText: true,
                                  onSaved: (input) => _password = input!),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // ignore: deprecated_member_use
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: login,

                        child: Text('LOGIN'),
                        style: ElevatedButton.styleFrom(

                            primary: Colors.teal,

                            textStyle:
                            TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Text('Create an Account?'),
              onTap: navigateToSignUp,
            )
          ],
        ),
      ),
    ));
  }
}
