import 'package:flutter/material.dart';

class entrepreneurPage extends StatelessWidget {
  const entrepreneurPage({super.key});

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
                  onPressed: () { print("Grow My Business clicked"); },
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

                  child: const Text('Grow My Business',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),




                const SizedBox(height: 30),




                OutlinedButton(
                  onPressed: () { print("Find Investors clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Find Investors', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),




                const SizedBox(height: 30),





                OutlinedButton(
                  onPressed: () { print("Build a Team clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Build a Team', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),






                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Launch a Product clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Launch a Product', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Start Something New clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Start Something New', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () { print("Sell clicked"); },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(400, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Sell', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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