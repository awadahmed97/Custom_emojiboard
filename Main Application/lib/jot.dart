// import 'package:flutter/material.dart';
// import 'package:custom_emojiboard/MyBottomNavBar.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'dart:typed_data';
// import 'package:custom_emojiboard/DataHolder.dart';

// class OtherPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _OtherPageState();
//   }
// }



// class _OtherPageState extends State<OtherPage> {
  
//   Widget makeImagesGrid() {
//     return GridView.builder(
//         itemCount: 40, ////////////////////////////////////////************************ */
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2),
//             itemBuilder: (context, index) {
//               return ImageGridItem(index + 1);
//             });
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:
//           AppBar(backgroundColor: Colors.blue[400], title: Text('My Uploads') //
//               ),
//       body: Container(
//         child: makeImagesGrid(), ////ImageGrid
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/other.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//       bottomNavigationBar: MyBottomNavBar(),
//     );
//   }
// }





// class ImageGridItem extends StatefulWidget {
//   int _index;

//   ImageGridItem(int index) {
//     this._index = index;
//     // this.databaseReference = db;
//   }

//   // @override
//   createState() => _ImageGridItemState();
// }

// class _ImageGridItemState extends State<ImageGridItem> {
//   // // Realtime Database Reference
//   final db = FirebaseDatabase.instance
//       .reference()
//       .child("All_Emoji_Uploads_Database/");


//     StorageReference emojisReferencePng =
//       FirebaseStorage.instance.ref().child("All_Emoji_Uploads/PNGs/");


//   String img_name;
//   int MAX_SIZE = 7 * 1024 * 1024; //7mb
//   var arr = [];
//   Uint8List imageFile;



//   getImagePng() {
//     if (!requestedIndexes.contains(widget._index)) {
//       //checks if index is requested yet
//       emojisReferencePng.child("PNG_${widget._index}.png")
//           .getData(MAX_SIZE)
//           .then((data) {
//             this.setState(() {
//               imageFile = data;
//             });
//             imageData.putIfAbsent(widget._index, () {
//               return data; //keeps image file data saved
//             });
//           }).catchError((error) {
//             //return nothing incase of error
//             });
//       requestedIndexes.add(widget._index);
//     }

//   }







//   Widget decideGridTileWidget() {
//     if (imageFile == null) {
//       return Center(child: Text(""));
//     } 
//     else {
//       return Image.memory(
//         imageFile,
//         fit: BoxFit.cover,
//       );
//     }
//   }




//   @override
//   void initState() {
//     super.initState();
//     if (!imageData.containsKey(widget._index)) {
//       getImagePng();
//     } else {
//       this.setState(() {
//         imageFile = imageData[widget._index];
//       });
//     }
//   }




//   @override
//   Widget build(BuildContext context) {
//     return GridTile(child: decideGridTileWidget());
//   }
// }

