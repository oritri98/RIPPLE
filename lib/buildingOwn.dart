import 'package:flutter/material.dart';

class buildingOwnPage extends StatelessWidget {
  const buildingOwnPage({super.key});

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
                  onPressed: () { print("Startup clicked"); },
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

                  child: const Text('Startup',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),




                const SizedBox(height: 30),




                OutlinedButton(
                  onPressed: () { print("Freelance clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Freelance', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),




                const SizedBox(height: 30),





                OutlinedButton(
                  onPressed: () { print("Small Business clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Small Business', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),






                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Personal Brand clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Personal Brand', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Creative Project clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Creative Project', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Side Hustle clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Side Hustle', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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