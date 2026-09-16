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




               //clickable button add kora instead
              //code taken from https://www.geeksforgeeks.org/flutter




              const SizedBox(height: 40),



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
                child: const Text('Working'),
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
                child: const Text('Working'),
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
                child: const Text('Working'),
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
                child: const Text('Working'),
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
                child: const Text('Working'),
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
                child: const Text('Working'),
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
                child: const Text('Working'),
              ),

              const SizedBox(height: 30),





             // button add done





            ], //children end
          ),
        ),
      ),
    ),
  ),
);