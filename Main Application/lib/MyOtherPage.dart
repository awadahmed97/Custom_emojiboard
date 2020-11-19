import 'package:flutter/material.dart';
import 'package:custom_emojiboard/MyBottomNavBar.dart';

class OtherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OtherPageState();
  }
}

class _OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[200], title: Text('Custom Emojiboard') //
          ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/other.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
