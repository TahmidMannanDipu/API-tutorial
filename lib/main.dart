import 'package:apitutorials/example_two.dart';
import 'package:apitutorials/home_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Tutorial',
      theme: ThemeData(
        primaryColor: Colors.blueAccent
      ),
      home: ExampleTwo(),
    );
  }
}
