import 'package:firebase_auth/firebase_auth.dart';
import 'package:custom_emojiboard/LoginPage.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(backgroundColor: Colors.blue[400], title: Text('Sign Up')),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Please enter valid email';
                      }
                    },
                    onSaved: (input) => _email = input,
                    decoration: InputDecoration(labelText: ' Email'),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.length < 6) {
                        return 'Please enter password';
                      }
                    },
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(labelText: ' Password'),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: signUp,
                    child: Text('Sign Up'),
                  ),
                  SizedBox(height: 500),
                ],
              ),
            ),
          ),
        ));
  }

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);

        ///user.user.sendEmailVerification();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
