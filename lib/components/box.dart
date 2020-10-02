import 'package:flutter/material.dart';

import '../constants.dart';

class Box extends StatelessWidget {
  final Widget childWidgets;
  final String title;

  const Box({Key key, this.childWidgets, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            color: boxcolor, borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            childWidgets,
          ],
        ),
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}
