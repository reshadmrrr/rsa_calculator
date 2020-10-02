import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  final String first;
  final dynamic second;

  const CustomText({Key key, this.first, this.second}) : super(key: key);
  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.first}:",
            style: TextStyle(fontSize: 16.0),
          ),
          SelectableText(
            "${widget.second}",
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
