import 'package:flutter/material.dart';


class MyBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: EdgeInsets.only(top: 15, bottom: 30),
      color: Colors.blue[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget> [
          IconButton(
            icon: Icon(Icons.home, size: 44.0,),
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          IconButton(
            icon: Icon(Icons.camera, size: 44.0,),
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/other');
            },
          ),
      ],
      ),

    );
  }
}
