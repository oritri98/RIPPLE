import 'package:flutter/material.dart';

class EducationSelection extends StatefulWidget {
  const EducationSelection({super.key});

  @override
  State<EducationSelection> createState() => _EducationSelectionState();
}

class _EducationSelectionState extends State<EducationSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 36, 36),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

           

            const Text(
              'Education',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 250, 252, 251),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Set up your education preferences',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 109, 76, 65),
              ),
            ),

            const SizedBox(height: 10),

            

            const Text(
              'UPLOAD STUDY MATERIAL',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 250, 252, 251),
              ),
            ),

            const SizedBox(height: 5),

            GestureDetector(
              onTap: () {
               //handle upload study material thing here 
              },

              child: Container(
                width: double.infinity,
                height: 80,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 109, 76, 65),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Row(
                  children: const [

                    SizedBox(width: 8),

                    Icon(
                      Icons.upload_file,
                      color: Colors.white,
                    ),

                    SizedBox(width: 10),

                    Text(
                      'Upload Study Material',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

           

            const Text(
              'STUDY FREQUENCY',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 109, 76, 65),
              ),
            ),

            const SizedBox(height: 5),

           

            SizedBox(
              width: double.infinity,
              height: 80,

              child: ElevatedButton(
                onPressed: () {
                  // Handle daily study frequency
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 109, 76, 65),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),

                child: const Text(
                  'DAILY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          

            SizedBox(
              width: double.infinity,
              height: 80,

              child: ElevatedButton(
                onPressed: () {
                  // Handle weekly study frequency
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 109, 76, 65),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),

                child: const Text(
                  'WEEKLY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            

            SizedBox(
              width: double.infinity,
              height: 80,

              child: ElevatedButton(
                onPressed: () {
                  // Handle monthly study frequency
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 109, 76, 65),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),

                child: const Text(
                  'MONTHLY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

           

            const Text(
              'FOCUS AREA',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 109, 76, 65),
              ),
            ),

            // Reduced from 20 to 5
            const SizedBox(height: 5),

           

            Container(
              width: double.infinity,
              height: 50,

              color: const Color.fromARGB(255, 109, 76, 65),

              child: Row(
                children: const [

                  SizedBox(width: 8),

                  Icon(
                    Icons.person,
                    color: Colors.white,
                  ),

                  SizedBox(width: 8),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(
                        'Self',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 3),

                      Text(
                        'This is for your personal growth',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

           

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: () {
                  // Handle save and continue
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 109, 76, 65),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),

                child: const Text(
                  'Save & Continue',

                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}