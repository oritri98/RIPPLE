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

              
              ElevatedButton(
                onPressed: () {
                  print("Elevated button clicked");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Rounded Elevated Button'),
              ),



              const SizedBox(height: 16),



              //diff type arekta button add


              OutlinedButton(
                onPressed: () {
                  print("Outlined button clicked");
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text('Rounded Outlined Button'),
              ),


             //2nd button add done





            ], //children end
          ),
        ),
      ),
    ),
  ),
);