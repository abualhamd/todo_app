import 'package:flutter/material.dart';

InputDecoration kInputDecoration = InputDecoration(
  // focusColor: Colors.lightBlueAccent,
  border: OutlineInputBorder(
      borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent),
      borderRadius: BorderRadius.circular(20)),
  filled: true,
  fillColor: Colors.grey[200],
  hoverColor: Colors.lightBlueAccent,
  prefixIcon: Icon(
    Icons.title,
    color: Colors.grey[400],
  ),
  // prefixIconColor: ,
  label: Text('Title', style: TextStyle(color: Colors.grey[400])),
);
