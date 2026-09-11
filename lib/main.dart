import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(24.0),


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What stage are you at?',
                style: TextStyle( color: Colors.white, fontSize: 50,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);