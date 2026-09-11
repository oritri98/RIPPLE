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
                style: TextStyle(
                    color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.school_outlined, color: Colors.white),
                  Text('Student', style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                ],
              ),

          const SizedBox(height: 30),
          Container(
            width: 160,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(5),

            ),
          ),



            ], //children
          ),
        ),
      ),
    ),
  ),
);