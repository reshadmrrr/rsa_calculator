import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPressed;

  const Button({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: onPressed,
      child: Text("Save"),
    );
  }
}
