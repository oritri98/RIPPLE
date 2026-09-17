import 'package:flutter/material.dart';

class changingCareerPage extends StatelessWidget {
  const changingCareerPage({super.key});

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
                  'What are you working toward?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),




                const SizedBox(height: 40),



                //clickable button add kora instead

                //code taken from https://www.geeksforgeeks.org/flutter



                OutlinedButton(
                  onPressed: () { print("Switch Industry clicked"); },
                  style: OutlinedButton.styleFrom(

                    // button size control kora

                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),


                  //button er bhitorer text bold and size control

                  child: const Text('Switch Industry',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),




                const SizedBox(height: 30),




                OutlinedButton(
                  onPressed: () { print("Learn New Skills clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Learn New Skills', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),




                const SizedBox(height: 30),





                OutlinedButton(
                  onPressed: () { print("Go Back to University clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Go Back to University', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),






                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Start Freelancing clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Start Freelancing', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Start a Business clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
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
                  onPressed: () { print("Not Sure Yet clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Not Sure Yet', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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