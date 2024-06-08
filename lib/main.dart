import 'package:flutter/material.dart';
import'home.dart';
// import 'constatation.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}