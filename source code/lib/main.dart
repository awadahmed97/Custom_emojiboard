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



        floatingActionButton: FloatingActionButton
          (
          onPressed: ()
          {
            //TODO: add onpressed code
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,




          //bottom navbar
          bottomNavigationBar: BottomNavigationBar(

            backgroundColor: Colors.blue[200],

            items:
            [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('HOME'),

              ),



              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                title: Text('HOME'),

              )

            ],

          ),

        ),

      );

  }
}


