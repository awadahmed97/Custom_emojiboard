import 'package:custom_emojiboard/LoginPage.dart';
import 'package:custom_emojiboard/MyGifPage.dart';
import 'package:flutter/material.dart';
import 'package:custom_emojiboard/MyHomePage.dart';
import 'package:custom_emojiboard/MyPngPage.dart';
import 'package:custom_emojiboard/MyBottomNavBar.dart';
import 'package:custom_emojiboard/MyJpgPage.dart';
import 'package:custom_emojiboard/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CustomEmojiApp",
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/png': (context) => PngPage(),
        '/jpg': (context) => JpgPage(),
        '/gif': (context) => GifPage(),
        '/login': (context) => LoginPage()
      },
    );
  }
}
