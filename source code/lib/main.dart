//
//
//


import 'package:flutter/material.dart';



void main()
{
  runApp(CustomEmojiApp());
}



class CustomEmojiApp extends StatelessWidget
{
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.blue[200],

          title: Text('Custom Emojiboard') //

        ),


        body: null,  //TODO: IMPLEMENT BODY WIDGETS


      ),



    );
  }
}


