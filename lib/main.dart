import 'package:apitutorials/example_four.dart';
import 'package:flutter/material.dart';

import 'example_three.dart';

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
      home: const ExampleFour()
    );
  }
}
