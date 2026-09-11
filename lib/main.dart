import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            'What stage are you at?',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
      ),
    ),
  ),
);