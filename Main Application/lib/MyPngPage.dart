import 'package:flutter/material.dart';
import 'package:custom_emojiboard/MyBottomNavBar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:typed_data';
import 'package:custom_emojiboard/PngData.dart';

class PngPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PngPageState();
  }
}



class _PngPageState extends State<PngPage> {

// Database Reference to png uploads count
var dbRefCount = FirebaseDatabase.instance.reference().child("Uploads_Count/PNG");  //

  //Grid View builder widget
  Widget makeImagesGrid(int pngCount) {
    return GridView.builder(
        itemCount: pngCount, //cont of PNG's uploaded to to know how many grids slots to build 
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemBuilder: (context, index) {
            return ImageGridItem(index + 1);
          });
  }


  /*
  Function to return total PNG uploaded to be used to build grid view.

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
                  AppBar(backgroundColor: Colors.blue[400], title: Text('My PNGs') //
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
  // Realtime Database Reference
  final db = FirebaseDatabase.instance
      .reference().child("All_Emoji_Uploads_Database/");

  //Storage reference to png directory
  StorageReference emojisReferencePng =
    FirebaseStorage.instance.ref().child("All_Emoji_Uploads/PNGs/");


  String img_name;
  int MAX_SIZE = 7 * 1024 * 1024; //7mb
  var arr = [];
  Uint8List imageFile;



  getImagePng() {
    // if (!requestedIndexes.contains(widget._index)) 
    // {
      //checks if index is requested yet
      emojisReferencePng.child("PNG_${widget._index}.png").getData(MAX_SIZE)
      .then((data) 
      {
        this.setState(() 
        {
          imageFile = data;
        });

        imageData.putIfAbsent(widget._index, () 
        {
          return data; //keeps image file data saved
        });
      }).catchError((error) 
        {
            //return nothing incase of error
        });
      
      // requestedIndexes.add(widget._index);
    // }

  }



  Widget decideGridTileWidget() {
    if (imageFile == null) {
      return Center(child: Text(""));
    } 
    else {
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
    } 
    else {
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

