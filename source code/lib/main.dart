//
//
//

import 'package:flutter/material.dart';


import 'ImageSelect.dart';

void main()
{
  runApp(CustomEmojiApp());
}

// Widget viewSelectedImage(context)
//   {
        
//      if (imageFile == null)
//       {
//         return Text('No Image Selected');  //placeholder for now
//       }
//       else
//       {
//         return Image.file(imageFile, width: 400, height: 400); 
//       }
//   }


class CustomEmojiApp extends StatelessWidget
{
  



  Widget _decideImageView() {
    if(imageFile == null) {
      return Text("No Image Selected!");
    } else {
      var image = Image.file(imageFile,width: 400,height: 400);
      return image;
    }
  }

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

          child: null
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,

          //     children: <Widget>
          //     [
          //       viewSelectedImage(context)
          //     ],
          //   )
          // ),
        ),
<<<<<<< HEAD
        child: Center(
            child: _decideImageView()
        )/* add child content here */,
      ),
=======
>>>>>>> 4a8daed10056668dc437f187a102530b260f316c

          

        floatingActionButton: ImageSelect(),
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,



<<<<<<< HEAD
      //bottom navbar
      bottomNavigationBar: BottomNavigationBar(
=======

        //bottom navbar
        bottomNavigationBar: BottomNavigationBar(

          backgroundColor: Colors.blue[200],
>>>>>>> 4a8daed10056668dc437f187a102530b260f316c

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
<<<<<<< HEAD
}
=======
}


>>>>>>> 4a8daed10056668dc437f187a102530b260f316c
