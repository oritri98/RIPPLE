import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(

    home: Scaffold(
      backgroundColor: Colors.brown,
      // Color ta arektu dark korbo
      body: Center(
        child: Text(
          'What stage are you at?',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
    ),
  ),
);