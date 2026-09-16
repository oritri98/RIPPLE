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
              //Dribble

              OutlinedButton(
                onPressed: () {

                  print("Student button clicked!");
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  side: const BorderSide(color: Colors.white54, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.school_outlined, color: Colors.white),
                      Text('Student', style: TextStyle(color: Colors.white)),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),


              //ekta button add kora done












            ], //children end
          ),
        ),
      ),
    ),
  ),
);