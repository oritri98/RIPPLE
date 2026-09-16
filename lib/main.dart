import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      // Brown color Color(0xFF2C1E16) eita chosen
      backgroundColor: Color(0xFF2C1E16),
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




               //clickable button add kora instead
              //code taken from https://www.geeksforgeeks.org/flutter




              const SizedBox(height: 40),



              OutlinedButton(
                onPressed: () {
                  print("High School clicked");
                },
                style: OutlinedButton.styleFrom(
                  //button size control kora
                  minimumSize: const Size(300, 60),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('High School',style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
              ),




              const SizedBox(height: 30),





              OutlinedButton(
                onPressed: () {
                  print("University Student clicked");
                },
                style: OutlinedButton.styleFrom(
                  //button size control kora
                  minimumSize: const Size(300, 60),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('University Student', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              const SizedBox(height: 30),


              OutlinedButton(
                onPressed: () {
                  print("Just Graduated clicked");
                },
                style: OutlinedButton.styleFrom(
                  //button size control kora
                  minimumSize: const Size(300, 60),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Just Graduated', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              const SizedBox(height: 30),


              OutlinedButton(
                onPressed: () {
                  print("Working clicked");
                },
                style: OutlinedButton.styleFrom(
                  //button size control kora
                  minimumSize: const Size(300, 60),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Working', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              const SizedBox(height: 30),


              OutlinedButton(
                onPressed: () {
                  print("Changing Careers clicked");
                },
                style: OutlinedButton.styleFrom(
                  //button size control kora
                  minimumSize: const Size(300, 60),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Changing Careers', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              const SizedBox(height: 30),


              OutlinedButton(
                onPressed: () {
                  print("Building My Own Thing clicked");
                },
                style: OutlinedButton.styleFrom(
                  //button size control kora
                  minimumSize: const Size(300, 60),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Building My Own Thing', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              const SizedBox(height: 30),

              OutlinedButton(
                onPressed: () {
                  print("Entrepreneur clicked");
                },
                style: OutlinedButton.styleFrom(
                  //button size control kora
                  minimumSize: const Size(300, 60),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Entrepreneur', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                ),

              ),

              const SizedBox(height: 30),







             // 7 buttons add kora done (same style)





            ], //children end
          ),
        ),
      ),
    ),
  ),
);