import 'package:flutter/material.dart';
import 'highSchool.dart';
import 'uniStudent.dart';
import 'justGrad.dart';
import 'working.dart';
import 'changingCareer.dart';
import 'buildingOwn.dart';
import 'entrepreneur.dart';


class StageSelectionPage extends StatelessWidget {
  const StageSelectionPage({super.key});

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
                  'What stage are you at?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),




                const SizedBox(height: 40),



                //clickable button add kora instead

                //code taken from https://www.geeksforgeeks.org/flutter



                OutlinedButton(
                  onPressed: () {

                    //new screen e navigate kora

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HighSchoolPage(),
                      ),
                    );
                  },



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

                  child: const Text('High School',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),




                const SizedBox(height: 30),




                OutlinedButton(
                    onPressed: () {

                      //new screen e navigate kora

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const uniStudentPage(),
                        ),
                      );
                    },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('University Student', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),




                const SizedBox(height: 30),





                OutlinedButton(
                  onPressed: () {

                    //new screen e navigate kora

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const justGradPage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Just Graduated', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),






                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () {

                    //new screen e navigate kora

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const workingPage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Working', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () {

                    //new screen e navigate kora

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const changingCareerPage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Changing Careers', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () {

                    //new screen e navigate kora

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const buildingOwnPage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Building My Own Thing', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),





                const SizedBox(height: 30),






                OutlinedButton(
                  onPressed: () {

                    //new screen e navigate kora

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const entrepreneurPage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(300, 60),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Entrepreneur', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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