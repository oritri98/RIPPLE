import 'package:flutter/material.dart';

class workingPage extends StatelessWidget {
  const workingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Brown color Color(0xFF1E140F) eita chosen, not Color(0xFF2C1E16)
      backgroundColor: const Color(0xFF1E140F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),



          // smaller phone hoile user can scroll down and crashing/overflowing hobe na
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What is your next plan?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),




                const SizedBox(height: 40),



                //clickable button add kora instead

                //code taken from https://www.geeksforgeeks.org/flutter



                OutlinedButton(
                  onPressed: () { print("Grow in My Career clicked"); },
                  style: OutlinedButton.styleFrom(

                    // button size control kora

                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),


                  //button er bhitorer text bold and size control

                  child: const Text('Grow in My Career',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),




                const SizedBox(height: 30),




                OutlinedButton(
                  onPressed: () { print("Change Careers clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Change Careers', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),




                const SizedBox(height: 30),





                OutlinedButton(
                  onPressed: () { print("Higher Salary clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Higher Salary', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),






                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Start a Business clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Start a Business', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Work Abroad clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Work Abroad', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Better Work-Life Balance clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Better Work-Life Balance', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),







                // 7 buttons add kora done (same style)

              ], ////children end
            ),
          ),
        ),
      ),
    );
  }
}