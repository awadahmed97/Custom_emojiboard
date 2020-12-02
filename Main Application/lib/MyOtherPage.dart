import 'package:custom_emojiboard/MyBottomNavBar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:custom_emojiboard/DataHolder.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class OtherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OtherPageState();
  }
}

class _OtherPageState extends State<OtherPage> {
  // Realtime Database Reference for Number of Uploads
  final dbUploadCount =
      FirebaseDatabase.instance.reference().child("Number_Of_Uploads");

  Widget makeImagesGrid() {
    return GridView.builder(
        itemCount:
            20, ////////////////////////////////////////************************ */
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return ImageGridItem(index + 1);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[400], title: Text('My PNG Uploads') //
          ),
      body: Container(
        child: makeImagesGrid(), ////ImageGrid
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/other.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

class ImageGridItem extends StatefulWidget {
  int _index;

  ImageGridItem(int index) {
    this._index = index;
    // this.databaseReference = db;
  }

  // @override
  createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  // // Realtime Database Reference
  final db = FirebaseDatabase.instance
      .reference()
      .child("All_Emoji_Uploads_Database/");

  StorageReference emojisReferenceJpg =
      FirebaseStorage.instance.ref().child("All_Emoji_Uploads/JPGs");

  StorageReference emojisReferencePng =
      FirebaseStorage.instance.ref().child("All_Emoji_Uploads/PNGs");

  StorageReference emojisReferenceGif =
      FirebaseStorage.instance.ref().child("All_Emoji_Uploads/GIFs");

  String img_name;
  int MAX_SIZE = 7 * 1024 * 1024; //7mb
  var arr = [];
  Uint8List imageFile;

  getImagePng() {
    if (!requestedIndexes.contains(widget._index)) {
      //checks if index is requested yet
      emojisReferencePng
          .child("emoji_${widget._index}.png") //PNG for now
          .getData(MAX_SIZE)
          .then((data) {
        this.setState(() {
          imageFile = data;
        });
        imageData.putIfAbsent(widget._index, () {
          return data; //keeps image file data saved
        });
      }).catchError((error) {
        //return nothing incase of error
      });
      requestedIndexes.add(widget._index);
    }

    // print("qqq: ${arr.length} ")
  }

  getImageJpg() {
    if (!requestedIndexes.contains(widget._index)) {
      //checks if index is requested yet
      emojisReferenceJpg
          .child("emoji_${widget._index}.jpg")
          .getData(MAX_SIZE)
          .then((data) {
        this.setState(() {
          imageFile = data;
        });
        imageData.putIfAbsent(widget._index, () {
          return data; //keeps image file data saved
        });
      }).catchError((error) {
        //return nothing incase of error
      });
      requestedIndexes.add(widget._index);
    }

    // print("qqq: ${arr.length} ")
  }

  getImageGif() {
    if (!requestedIndexes.contains(widget._index)) {
      //checks if index is requested yet
      emojisReferenceGif
          .child("emoji_${widget._index}.gif")
          .getData(MAX_SIZE)
          .then((data) {
        this.setState(() {
          imageFile = data;
        });
        imageData.putIfAbsent(widget._index, () {
          return data; //keeps image file data saved
        });
      }).catchError((error) {
        //return nothing incase of error
      });
      requestedIndexes.add(widget._index);
    }

    // print("qqq: ${arr.length} ")
  }

  Widget decideGridTileWidget() {
    if (imageFile == null) {
      return Center(child: Text("No Data"));
    } else {
      return Image.memory(
        imageFile,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (!imageData.containsKey(widget._index)) {
      getImagePng();
      //THought i could create thier own functions and call each but that did not work.
      // getImageJpg();
      // getImageGif();
    } else {
      this.setState(() {
        imageFile = imageData[widget._index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(child: decideGridTileWidget());
  }
}

// getImage(){

//     db.once().then((DataSnapshot snapshot){
//       Map<dynamic, dynamic> values = snapshot.value;
//         values.forEach((key,values) {
//           print("Hello over here:" + values["imageName"]);
//           img_name = values["imageName"];

//           emojisReference.child(img_name)
//           .getData(MAX_SIZE)
//           .then((data){
//             this.setState(() {
//               imageFile = data;
//             });

//           })
//           .catchError((error) {
//             //return nothing incase of error

//           });

//         });
//     });

//   }
