import 'package:apitutorials/get_example/example_four.dart';
import 'package:apitutorials/post_example/signup/login.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Tutorial',
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home:const LoginScreen(),
    );
  }
}
