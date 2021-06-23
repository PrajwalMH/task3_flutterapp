import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task3_flutterapp/account.dart';
import 'package:task3_flutterapp/my_shared_preferences.dart';
import 'package:task3_flutterapp/profile.dart';


class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddState();
  }
}

class AddState extends State<Add> {
  TextEditingController controllerld = new TextEditingController();
  TextEditingController controllercity = new TextEditingController();
  TextEditingController controllerst = new TextEditingController();
  

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          appBar: new AppBar(
            title: Center(child: Text('Enter address')),
            backgroundColor: Colors.teal,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(25),
              child: Form(
                autovalidateMode: AutovalidateMode.disabled, key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Landmark:", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: controllerld,
                            decoration: InputDecoration(
                              hintText: "Please enter Landmark",
                            ),
                            
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Landmark is Required";
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("City:", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Please enter username",
                              ),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "UserName is Required";
                                }
                              },
                              controller: controllercity),
                        )
                      ],
                    ),
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("State:", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: controllerst,
                            decoration: InputDecoration(
                              hintText: "Please enter State",
                            ),

                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "State is Required";
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 100),
                    SizedBox(
                      width: 150,
                      height: 50,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: Colors.grey,
                        child: Text("Submit",
                            style: TextStyle(color: Colors.white, fontSize: 18)),
                        onPressed: () {
                          if(formKey.currentState!.validate()) {
                            var getld = controllerld.text;
                            var getcity = controllercity.text;
                            var getst = controllerst.text;

                            MySharedPreferences.instance
                                .setStringValue("landmark", getld);
                            MySharedPreferences.instance
                                .setStringValue("city", getcity);
                            MySharedPreferences.instance
                                .setStringValue("state", getst);
                            MySharedPreferences.instance
                                .setBooleanValue("loggedin", true);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => Profile()),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}