import 'package:flutter/material.dart';
import 'package:rsa_calculator/home-page.dart';

const String appTitle = 'RSA Calculator';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        fontFamily: "Century",
        primaryColor: Color(0xffffffff),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: appTitle),
    );
  }
}
