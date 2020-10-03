import 'package:flutter/material.dart';
import 'package:rsa_calculator/home-page.dart';

import 'constants.dart';

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
      theme: defaultTheme,
      home: HomePage(title: appTitle),
    );
  }
}
