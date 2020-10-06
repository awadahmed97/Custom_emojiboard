//
//
//

import 'package:flutter/material.dart';


import 'ImageSelect.dart';

void main()
{
  runApp(CustomEmojiApp());
}

Widget viewSelectedImage(context)
  {
        
     if (imageFile == null)
      {
        return Text('No Image Selected');  //placeholder for now
      }
      else
      {
        return Image.file(imageFile, width: 400, height: 400); 
      }
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


        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bulbs.jpg"),
              fit: BoxFit.cover,
            ),
          ),

          child: 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget>
              [
                viewSelectedImage(context)
              ],
            )
          ),
        ),

          

        floatingActionButton: ImageSelect(),
        
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
              title: Text('ABOUT'),

            )

          ],

        ),

      ),

    );

  }
}


