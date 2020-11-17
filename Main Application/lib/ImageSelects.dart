




// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';




// //A reference to a file(image) on the file system(Phone Gallery)
//   File imageFile;

//   //R reference to a cropped image
//   File croppedFile;
  
  
//   //openGallery funtion definitions
//   openGallery(BuildContext context) async  //Tells app to wait untill user selects image, however long that takes them to complete that action.
//   {
//     var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
//     this.setState(() {
//       imageFile = picture;
//     });

//     //Close the dialogbox after image is selected
//     Navigator.of(context).pop();
//   }

 
//   //openCamera funtion definitions
//   openCamera(BuildContext context) async
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