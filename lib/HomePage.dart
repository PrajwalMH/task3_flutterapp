import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task3_flutterapp/Start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:authentification/Start.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task3_flutterapp/account.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Razorpay _razorpay;
  bool s = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool isloggedin = false;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    this.checkAuthentification();
    this.getUser();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Your Payment is successful" + response.paymentId.toString());
    s = true;
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Your payment has failed and the reason is" +
            response.code.toString() +
            " - " +
            response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "Redirecting to external Wallet" + response.walletName.toString());
  }

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
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

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  callRazorpay() async {
    var options = {
      "key": "rzp_test_P14y3GfOXCcoAQ",
      'amount': 20000,
      'name': 'Prajwal M Hulamani',
      'description': 'for order Payment',
      'prefill': {'contact': '9352648365', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (msg) {
      print(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isloggedin
        ? CircularProgressIndicator()
        : Scaffold(
            drawer: Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.teal[300],
                    ),
                    child: Stack(children: <Widget>[
                      Positioned(
                        right: 80,
                        top: 20,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person_pin),
                            Text(
                              'Its ${user.displayName}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Accountpage()),
                                    );
                                  });
                                }),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  ListTile(
                    title: Text("Order History"),
                    leading: Icon(Icons.format_list_bulleted),
                    onTap: () {
                      print('Order history');
                    },
                  ),
                  ListTile(
                    title: Text("Help and Support"),
                    leading: Icon(Icons.phone),
                    onTap: () {
                      print("Help and Support");
                    },
                  ),
                  ListTile(
                    title: Text("Updates"),
                    leading: Icon(Icons.loop),
                    onTap: () {
                      print("Updates");
                    },
                  ),
                  ListTile(
                    title: Text("Log out"),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Retrieve the text the that user has entered by using the
                            // TextEditingController.
                            content: Text(
                              'Are you sure you want to logout',
                              textAlign: TextAlign.center,
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: signOut,
                                child: Text('Yes'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            appBar: new AppBar(
              title: Text('Homepage'),
              backgroundColor: Colors.teal,
            ),
            body: !isloggedin
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Image(image: AssetImage('assets/ppp.jpg')),
                          SizedBox(
                            height: 100,
                          ),
                          Center(
                            child: Text(
                              "Hello ${user.displayName}\n ,you are Logged in as ${user.email}",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          //ignore: deprecated_member_use
                          ElevatedButton(
                              onPressed: () {
                                callRazorpay();
                              },
                              child: Text('Razorpay')),
                          Text(s ? "Payment is done" : ""),

                        ],
                      ),
                    ),
                  ),
          );
  }
}
