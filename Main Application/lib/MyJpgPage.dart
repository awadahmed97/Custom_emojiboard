import 'package:custom_emojiboard/MyBottomNavBar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:custom_emojiboard/JpgData.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class JpgPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JpgPageState();
  }
}

class _JpgPageState extends State<JpgPage> {
  
  // Database Reference to png uploads count
  var dbRefCount = FirebaseDatabase.instance.reference().child("Uploads_Count/JPG");  //

  //Grid View builder widget
  Widget makeImagesGrid(int jpgCount) {
    return GridView.builder(
        itemCount: jpgCount, //cont of JPG's uploaded to to know how many grids slots to build 
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemBuilder: (context, index) {
            return ImageGridItem(index + 1);
          });
  }


  /*
  Function to return total JPG uploaded to be used to build grid view.

  */
  Future<String> getUploadCount() async
  {
      String mySnapShot;
      String uploadsNumStr;
      
      //Get number of emoji uploads from Realtime Database
      await dbRefCount.once().then((DataSnapshot snapshot) {
        mySnapShot = snapshot.value.toString();                      //Number is retuned in this format: {count: 10}
        uploadsNumStr = mySnapShot.substring(7, mySnapShot.length - 1); //Substring to get number part only: 10
      });
        
      return uploadsNumStr;
  }




    

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  //// Build Method. Future Builder used to get uploads count.
  @override
    Widget build(context) {
      return FutureBuilder<String>(
        future: getUploadCount(),   //returns a string number.
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return  Scaffold(
              appBar:
                  AppBar(backgroundColor: Colors.blue[400], title: Text('My JPGs') //
                      ),
              body: Container(
                child:makeImagesGrid(int.parse(snapshot.data)), ////ImageGrid
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/white.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              bottomNavigationBar: MyBottomNavBar(),
            );
          
          } 
          
          
          else {      //else show circular loading bar
            return Column(
              children: <Widget> 
              [
                Padding(padding: EdgeInsets.only(top: 400)),

                SizedBox ( 
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),   
                ),

                Padding(padding: EdgeInsets.only(top: 16)),

                // Text('Retrieving Data...),
                
              ]
            ); 
            
          }  //end of else
        }
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
      .reference().child("All_Emoji_Uploads_Database/");

  //Storage reference to jpg directory
  StorageReference emojisReferenceJpg =
      FirebaseStorage.instance.ref().child("All_Emoji_Uploads/JPGs");

  int MAX_SIZE = 7 * 1024 * 1024; //7mb
  var arr = [];
  Uint8List imageFile;

  getImageJpg() {
    // if (!requestedJpgIndexes.contains(widget._index)) {
      //checks if index is requested yet
      emojisReferenceJpg
          .child("JPG_${widget._index}.jpg")
          .getData(MAX_SIZE)
          .then((data) {
        this.setState(() {
          imageFile = data;
        });
        imageJpgData.putIfAbsent(widget._index, () {
          return data; //keeps image file data saved
        });
      }).catchError((error) {
        //return nothing incase of error
      });
    //   requestedJpgIndexes.add(widget._index);
    // }
  }

  Widget decideGridTileWidget() {
    if (imageFile == null) {
      return Center(child: Text(""));
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
    if (!imageJpgData.containsKey(widget._index)) {
      getImageJpg();
    } else {
      this.setState(() {
        imageFile = imageJpgData[widget._index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(child: decideGridTileWidget());
  }
}
