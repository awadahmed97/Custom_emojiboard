//Widget to control upload button and image selection



import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//global for now
File imageFile;



class ImageSelect extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    
    return _ImageSelectState();
  }
}




class _ImageSelectState extends State<ImageSelect>
{

  //A reference to a file on the file system
  // File imageFile;
  
  
  //openGallery and openCamera funtion definitions
  _openGallery(BuildContext context) async  //Tells app to wait untill user selects image, however long that takes them to complete that action.
  {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() 
    {
      imageFile = picture;
      // imageFileFunc(imageFile);
    });

    //Close the dialogbox after image is selected
    Navigator.of(context).pop();
  }

 

  _openCamera(BuildContext context) async
  {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() 
    {
      imageFile = picture;
      // imageFileFunc(imageFile);

    });

    //Close the dialogbox after image is selected
    Navigator.of(context).pop();
  }



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



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

  
    return FloatingActionButton
        (
          onPressed: ()
          {
            showChoiceDialog(context);            
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
        );
      
    
  } 
}