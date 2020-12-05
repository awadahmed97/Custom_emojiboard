import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_emojiboard/MyBottomNavBar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[400], title: Text('Sign In')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            buildTextField('Email', Icons.email),
            SizedBox(height: 10),
            buildTextField('Password', Icons.lock),
            SizedBox(height: 30),
            MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: () async {
                null;
              },
              color: Colors.green[300],
              child: Text('Login',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              textColor: Colors.white,
            ),
            SizedBox(height: 20),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: () async {
                final GoogleSignInAccount googleUser =
                    await googleSignIn.signIn();
                final GoogleSignInAuthentication googleAuth =
                    await googleUser.authentication;
                final AuthCredential credential =
                    GoogleAuthProvider.getCredential(
                        idToken: googleAuth.idToken,
                        accessToken: googleAuth.accessToken);
                final FirebaseUser user =
                    (await firebaseAuth.signInWithCredential(credential)).user;
              },
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.google),
                  SizedBox(width: 10),
                  Text('Sign-in using Google',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              textColor: Colors.white,
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  buildTextField(String labelText, IconData icon) {
    return Container(
      margin: EdgeInsets.all(15),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
