import 'package:flutter/material.dart';
import 'package:custom_emojiboard/MyBottomNavBar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';



class Uploader extends StatefulWidget {
  final File file;
  Uploader({Key key, this.file}) : super(key: key);

  createState() => UploaderState();
}



class UploaderState extends State<Uploader> {

  // Realtime Database Path for images
  final String databasePath = "All_Emoji_Uploads_Database/";

  // Storage Path for images
  final String storagePath = "All_Emoji_Uploads/";

  // Realtime Database Reference
  final databaseReference = FirebaseDatabase.instance.reference();

  // Firebase Storage
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://custom-emojiboard.appspot.com');

  //
  StorageUploadTask _uploadTask;


  // Realtime Database Reference for sequence number
  final dbRefSeq = FirebaseDatabase.instance.reference().child("Number_Of_Uploads");




 






  //
  Future<void> _startUpload() async{

    String storageFilePath;

     // Realtime Database Reference to JPG's
    final rtJpgRefPath = storagePath + "JPGs/";

    // Realtime Database Reference to PNG's
    final rtPngRefPath = storagePath + "PNGs/";


    // Realtime Database Reference to GIF's
    final rtGifRefPath = storagePath + "GIFs/";




    
    //Generate new sequential image name
    String name = await genSeqImageName();

    // Get extension of image file to be uploaded
    String full_local_file_path = widget.file.path;
    String file_extension = full_local_file_path.split('.').last;

    //Assign new name to path
    if (file_extension == "jpg")
    {
      storageFilePath = rtJpgRefPath + name + "jpg";
    }
      if (file_extension == "png")
    {
      storageFilePath = rtPngRefPath + name + ".png";
    }
      if (file_extension == "gif")
    {
      storageFilePath = rtGifRefPath + name + ".gif";
    }


    // Set state
    setState(() {
      // Upload Image to storage path using generated name and extention
      _uploadTask = (_storage.ref()).child(storageFilePath).putFile(widget.file);  

      // Save reference of uploaded image to RTD
      saveReferenceToRealtimeDatabase(_uploadTask);
    });
  }


  //Function to generate sequential name based on number of files in RTD
  Future<String> genSeqImageName() async
  {
    //Variables
    int imgCounter = 0;
    String tempstr;
    String uploadsNumStr;
    
    //Get number of emoji uploads from Realtime Database
    await dbRefSeq.once().then((DataSnapshot snapshot) {
      tempstr = snapshot.value.toString();                      //Number is retuned in this format: {NUM: 27}
      uploadsNumStr = tempstr.substring(5, tempstr.length - 1); //Use substring to get number only
      // myList.add(uploadsNumStr);
      // print("This Is: " + tempstr);
    });
      
  
    //Convert number to int and Increment for new upload
    imgCounter = int.parse(uploadsNumStr);
    imgCounter++;
    // print(imgCounter);

    //Update new number in RTD
    dbRefSeq.set({
      'NUM': imgCounter,
    });

    //Convert incremented num back to string
    String tempCount = imgCounter.toString();

    //return new name with template prefex  "emoji_NUM"
    return "emoji_" + tempCount;  ///////////////Using PNG for now 
    // print(imgName);
   
  }







  // Function to save image url and name in realtime database
  Future<void> saveReferenceToRealtimeDatabase(StorageUploadTask uploadTask) async {
    // Get image URL
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();

    // Get Name
    String name = await (await uploadTask.onComplete).ref.getName();

    // print("This is the URL: " + url);
    // print("This is the name: " + name);

    // Add image reference data to database
    databaseReference.child(databasePath).push().set({
      'imageName': name,
      'imageURL': url
    });



  }



  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            return Column(

              children: [
                if (_uploadTask.isComplete)
                  Text('Uploaded'),
                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: null  //TODO: Code to resume upload
                  ),
                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),
                LinearProgressIndicator(value: progressPercent),
                Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % '
                ),
              ],
            );

          });

    } 
    else {

      return ButtonTheme(
        minWidth:150,

        child: RaisedButton(
          child: Icon(Icons.done),
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: _startUpload,
        )

      );

    }
  }
}

class HomePage extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() {

    return _HomePageState();
  }
}







class _HomePageState extends State<HomePage> {


  //A reference to a file(image) on the file system(Phone Gallery)
  File _imageFile;

  //openGallery funtion definition
  /**
   *
   *
   *
   */
  _openGallery(
      BuildContext context) async //Tells app to wait untill user selects image, however long that takes them to complete that action.
      {
    var picture = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      // maxWidth: 512,
      // maxHeight: 512,   //NOTE: Commented out because it causes GIF's to lose animation
    );
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
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
      // maxWidth: 512,
      // maxHeight: 512,
    );
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
  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }


  /**
   *
   *
   *
   */
  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
          title: Text('Select Image Source'),
          content: SingleChildScrollView(
              child: ListBody(
                  children: <Widget>
                  [
                    GestureDetector(
                        child: Text('Gallery'),

                        onTap: () {
                          _openGallery(context);
                        }

                    ),

                    Padding(padding: EdgeInsets.all(10.0)),

                    GestureDetector(
                        child: Text('Camera'),
                        onTap: () {
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

      appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Text('Custom Emojiboard') //
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          children: <Widget>
          [
            // if imageFile is NOT null, Body will show below children widgets.
            // Else, just the above container widgets
            if (_imageFile != null) ...
            [
              Padding(padding: EdgeInsets.all(8.0)),
              
              // Expanded makes image scale to fit without having to scroll
              Expanded(child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 4.0),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                
                child: Image.file(_imageFile),
 
                ),
              ),
              

              Row(
                children: <Widget>
                [
                  Padding(padding: EdgeInsets.all(20)),

                  ButtonTheme(
                    minWidth:120,

                    child: RaisedButton(
                      child: Icon(Icons.crop),
                      color: Colors.deepPurple,
                      textColor: Colors.white,

                      onPressed: _cropImage,
                    ),

                  ),
                  

                  Padding(padding: EdgeInsets.all(35)),


                  ButtonTheme(
                    minWidth:120,

                    child: RaisedButton(
                      child: Icon(Icons.clear),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      onPressed: _clear,
                    ),

                  ),

                  Padding(padding: EdgeInsets.all(20))

                  // Uploader(file: _imageFile),
                ],
              ),


              Uploader(file: _imageFile),

              Padding(padding: EdgeInsets.all(20.0)),
            
            ],  // end of if[]
            
            Container()  // else ..load -> body: Container()
            
          ],
        ),
      ),

      //Floating action bar
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showChoiceDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: MyBottomNavBar(),


    );
  }
}







// dbRefSeq.once().then((DataSnapshot snapshot) {
//       tempstr = snapshot.value.toString();
//       uploadsNumStr = tempstr.substring(5, tempstr.length - 1);
//       print( int.parse(snapshot.value["NUM"].toString()));
     
//     });
      
      
//       // print("This Is: " + uploadsNumStr);
