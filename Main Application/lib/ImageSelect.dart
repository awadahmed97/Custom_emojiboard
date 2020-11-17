// //Widget to control upload button and image selection



// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';


// //A reference to a file(image) on the file system(Phone Gallery)
// File imageFile;    //global for now



// class ImageSelect extends StatefulWidget
// {
  
//   @override
//   State<StatefulWidget> createState() {
    
//     return _ImageSelectState();
//   }
// }




// class _ImageSelectState extends State<ImageSelect>
// {
//   //A reference to a file(image) on the file system(Phone Gallery)
//   // File _imageFile;

//   //R reference to a cropped image
//   File _croppedFile;
  
  
//   //openGallery funtion definitions
//   _openGallery(BuildContext context) async  //Tells app to wait untill user selects image, however long that takes them to complete that action.
//   {
//     var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
//     this.setState(() {
//       imageFile = picture;
//     });

//     //Close the dialogbox after image is selected
//     Navigator.of(context).pop();
//   }

 
//   //openCamera funtion definitions
//   _openCamera(BuildContext context) async
//   {
//     var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
//     this.setState(() {
//       imageFile = picture;
//     });

//     //Close the dialogbox after image is selected
//     Navigator.of(context).pop();
//   }


//   //image cropper function
//   Future<void> _cropImage() async
//   {
//     var cropped = await ImageCropper.cropImage(
//       sourcePath: imageFile.path,
//       maxWidth: 512,
//       maxHeight: 512,

//       //Cropper UI widget settings
//       androidUiSettings: AndroidUiSettings
//       (
//         toolbarTitle: 'Crop Emoji Image',
//         toolbarColor: Colors.purple,
//         toolbarWidgetColor: Colors.white
//       )
//     );

//     this.setState(() {
//       imageFile = cropped ?? imageFile;  
//       //Dart's null aware "double questionmark" operator
//       //if user cancels cropping, cropped = null
//       // '??' => if _imageFile is null, cropped = _imageFile 
//     });
//   }



//  //clear [option for user to clear image after an image is picked]
//   void _clear()
//   {
//     setState(() {
//       imageFile = null;
//     });
//   }






//   Future<void> showChoiceDialog(BuildContext context) 
//   {
//     return showDialog(context: context, builder: (BuildContext context)
//     {
//       return AlertDialog(
//         title: Text('Select Image Source'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>
//             [
//               GestureDetector(
//                 child: Text('Gallery'), 

//                 onTap:()
//                 {
//                   _openGallery(context);
//                 }

//               ),

//               Padding(padding: EdgeInsets.all (10.0)),

//               GestureDetector(
//                 child: Text('Camera'),
//                 onTap:()
//                 {
//                   _openCamera(context);
//                 }

//               )
//             ]
//           )

//         )
//       );
//     });
//   }



//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build

  
//     return FloatingActionButton
//         (
//           onPressed: ()
//           {
//             showChoiceDialog(context);            
//           },
//           child: Icon(Icons.add),
//           backgroundColor: Colors.deepPurple,
//         );
      
    
//   } 
// }