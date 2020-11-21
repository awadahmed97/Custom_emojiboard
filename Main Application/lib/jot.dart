// import 'package:flutter/material.dart';
// import 'package:custom_emojiboard/MyBottomNavBar.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'dart:typed_data';





// import 'dart:io';


// import 'package:image_picker/image_picker.dart';

// class SecondPage extends StatefulWidget {
//   SecondPage({Key key}) : super(key: key);

//   @override
//   _SecondPageState createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage> {
//   final db = FirebaseDatabase.instance ; //.reference().child("All_Emoji_Uploads_Database/");
//   File _image;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: Text("Second Page"),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(10.0),
//         child: Column(children: <Widget>[
//           FutureBuilder(
//             future: getImages(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data.docs.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ListTile(
//                         contentPadding: EdgeInsets.all(8.0),
//                         title: Text(snapshot.data.docs[index].data()["name"]),
//                         leading: Image.network(
//                             snapshot.data.docs[index].data()["url"],
//                             fit: BoxFit.fill),
//                       );
//                     });
//               } else if (snapshot.connectionState == ConnectionState.none) {
//                 return Text("No data");
//               }
//               return CircularProgressIndicator();
//             },
//           ),
//           RaisedButton(child: Text("Pick Image"), onPressed: getImage),
//           _image == null
//               ? Text('No image selected.')
//               : Image.file(
//                   _image,
//                   height: 300,
//                 ),
//           RaisedButton(
//               child: Text("Save Image"),
//               onPressed: () async {
//                 if (_image != null) {
//                   StorageReference ref = FirebaseStorage.instance.ref();
//                   StorageTaskSnapshot addImg =
//                       await ref.child("All_Emoji_Uploads").putFile(_image).onComplete;
//                   if (addImg.error == null) {
//                     print("added to Firebase Storage");
//                   }
//                 }
//               }),
//         ]),
//       ),
//     ));
//   }

//   Future getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       _image = image;
//     });
//   }

//   Future getImages() {
//     return db.reference().child("All_Images_Uploads_Database").get(); //   collection("images").get();
//   }
// }