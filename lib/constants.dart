import 'package:flutter/material.dart';

const Color bgcolor = Color(0xfff2f2f2);
const Color boxcolor = Color(0xffffffff);
const Color blackcolor = Colors.black;

const InputDecoration inputDecoration = InputDecoration(
  errorStyle: TextStyle(color: Colors.black87),
  labelText: "Enter your labeltext",
  labelStyle: TextStyle(color: blackcolor),
  contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
  ),
);
