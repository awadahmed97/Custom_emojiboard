import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
void main() {
  runApp(new MaterialApp(
    title: "Camera App",
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  File imageFile;

  _openGallery(BuildContext context) async{
    var picture =  await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{
    var picture =  await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice!"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }



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
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Emojiboard"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bulbs.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: _decideImageView()
        )/* add child content here */,
      ),



      floatingActionButton: FloatingActionButton
        (
        onPressed: ()
        {
          _showChoiceDialog(context);
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
            title: Text('ABOUT'),

          )

        ],

      ),


    );

  }
}