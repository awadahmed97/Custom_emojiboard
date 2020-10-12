//
//
//

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';




void main()
{
  
  runApp(MaterialApp(
    title: "CustomEmojiApp",
    home: HomePage(),
  ));
}




class HomePage extends StatefulWidget
{
  
  @override
  State<StatefulWidget> createState() {
    
    return _HomePageState();
  }
}







class _HomePageState extends State<HomePage>
{


  //A reference to a file(image) on the file system(Phone Gallery)
  File _imageFile;

  //openGallery funtion definition
  /**
   * 
   * 
   * 
   */
  _openGallery(BuildContext context) async  //Tells app to wait untill user selects image, however long that takes them to complete that action.
  {
<<<<<<< HEAD
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
=======
    var picture = await ImagePicker.pickImage(
      source: ImageSource.gallery, 
      maxWidth: 512, 
      maxHeight: 512,
    );
>>>>>>> development
    this.setState(() {
      _imageFile = picture;
    });

    //Close the dialogbox after image is selected
    Navigator.of(context).pop();
  }

 
  //openCamera funtion definition
  /**
   * 
   * 
   * 
   */
  _openCamera(BuildContext context) async
  {
<<<<<<< HEAD
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
=======
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera, 
    maxWidth: 512, 
    maxHeight: 512,
  );
>>>>>>> development
    this.setState(() {
      _imageFile = picture;
    });

    //Close the dialogbox after image is selected
    Navigator.of(context).pop();
  }


  //image cropper function
  /**
   * 
   * 
   * 
   */
  Future<void> _cropImage() async
  {
    var cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      maxWidth: 512,
      maxHeight: 512,

      //Cropper UI widget settings
      androidUiSettings: AndroidUiSettings
      (
        toolbarTitle: 'Crop Emoji Image',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
      )
    );

    this.setState(() {
      _imageFile = cropped ?? _imageFile;  
      //Dart's null aware "double questionmark" operator
      //if user cancels cropping, cropped = null
      // '??' => if _imageFile is null, cropped = _imageFile 
    });
  }


  
  //clear [option for user to clear image after an image is picked]
  /**
   * 
   * 
   * 
   */
  void _clear()
  {
    setState(() {
      _imageFile = null;
    });
  }





  /**
   * 
   * 
   * 
   */
  Future<void> showChoiceDialog(BuildContext context) 
  {
    return showDialog(context: context, builder: (BuildContext context)
    {
      return AlertDialog(
        title: Text('Select Image Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>
            [
              GestureDetector(
                child: Text('Gallery'), 

                onTap:()
                {
                  _openGallery(context);
                }

              ),

              Padding(padding: EdgeInsets.all (10.0)),

              GestureDetector(
                child: Text('Camera'),
                onTap:()
                {
                  _openCamera(context);
                }

              )
            ]
          )
        )
      );
    });
  }






  /**
   * 
   * 
   * 
   */
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
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
    
        child: ListView(
          children: <Widget>
          [
            // if imageFile is NOT null, Body will show below children widgets. 
<<<<<<< HEAD
            // Else, just the above children widgets
            if (_imageFile != null) ...
            [
              Image.file(_imageFile),

              Row(
                children: <Widget>
                [
                  FlatButton(
                    child: Icon(Icons.crop),
                    onPressed: _cropImage,
                  ),

                  FlatButton(
                    child: Icon(Icons.refresh),
                    onPressed: _clear,
                  )
                ],
              ),


              // Uploader(file: _imageFile)

            ],  
          ],
        ),
      ),


=======
            // Else, just the above container widgets
            if (_imageFile != null) ...
            [
              Image.file(_imageFile),

              Row(
                children: <Widget>
                [
                  RaisedButton(
                    child: Icon(Icons.crop),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: _cropImage,
                  ),

                  Padding(padding: EdgeInsets.all (10.0)),

                  RaisedButton(
                    child: Icon(Icons.clear),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: _clear,
                  )
                ],
              ),


              // Uploader(file: _imageFile)

            ],  
          ],
        ),
      ),


>>>>>>> development
        
      //Floating action bar
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          showChoiceDialog(context);            
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,




      //Bottom navbar
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
            backgroundColor: Colors.white,
          )
        ],
      ),
    );
  }
}