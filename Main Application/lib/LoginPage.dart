import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_emojiboard/MyBottomNavBar.dart';
import 'package:custom_emojiboard/MyHomePage.dart';
import 'package:custom_emojiboard/SignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[400], title: Text('Sign In')),
      body: Form(
        //decoration: BoxDecoration(
        //image: DecorationImage(
        //image: AssetImage("assets/images/home.jpg"),
        //fit: BoxFit.cover,
        //),
        //),
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter valid email';
                  }
                },
                decoration: InputDecoration(labelText: ' Email'),
                onSaved: (input) => _email = input,
              ),
              TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Please enter longer password';
                  }
                },
                decoration: InputDecoration(labelText: ' Password'),
                onSaved: (input) => _password = input,
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: signIn,
                child: Text('Sign In'),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: navigateToSignUp,
                child: Text('Sign Up'),
              ),
              SizedBox(
                height: 10,
              ),
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
                      (await firebaseAuth.signInWithCredential(credential))
                          .user;
                },
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.google),
                    SizedBox(width: 10),
                    Text('Sign-in using Google',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ],
                ),
                textColor: Colors.white,
              ),
              SizedBox(height: 300),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUp(), fullscreenDialog: true));
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
