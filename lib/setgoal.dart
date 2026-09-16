import 'package:flutter/material.dart';

class SetGoal extends StatefulWidget {
  const SetGoal({super.key});

  @override
  State<SetGoal> createState() => _SetGoalState();
}

class _SetGoalState extends State<SetGoal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 27, 20),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const Text(
              'Set Goals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF896448),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Plan your goal and stay consistent',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF896448),
              ),
            ),

            const SizedBox(height: 10),

            // FIRST CONTAINER - DAILY GOALS
            Container(
              width: double.infinity,
              height: 120,
              padding: const EdgeInsets.all(8.0),

              decoration: BoxDecoration(
                color: const Color(0xFF482616),
                borderRadius: BorderRadius.circular(8.0),
              ),

              child: Column(
                children: [
                  const Text(
                    'Daily Goals',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    'Your Everyday Goals',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      // SUNDAY
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 60,
                          color: const Color(0xFFB2BEB5),

                          child: const Center(
                            child: Text(
                              'S',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // MONDAY
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 60,
                          color: const Color(0xFFB2BEB5),

                          child: const Center(
                            child: Text(
                              'M',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // TUESDAY
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 60,
                          color: const Color(0xFFB2BEB5),

                          child: const Center(
                            child: Text(
                              'T',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // WEDNESDAY
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 60,
                          color: const Color(0xFFB2BEB5),

                          child: const Center(
                            child: Text(
                              'W',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // THURSDAY
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 60,
                          color: const Color(0xFFB2BEB5),

                          child: const Center(
                            child: Text(
                              'T',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // FRIDAY
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 60,
                          color: const Color(0xFFB2BEB5),

                          child: const Center(
                            child: Text(
                              'F',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // SATURDAY
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 60,
                          color: const Color(0xFFB2BEB5),

                          child: const Center(
                            child: Text(
                              'S',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // SECOND CONTAINER - WEEKLY GOALS
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(12.0),

              decoration: BoxDecoration(
                color: const Color(0xFF482616),
                borderRadius: BorderRadius.circular(8.0),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    'Weekly Goals',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      color: Color(0xFFB2BEB5),
                    ),

                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // THIRD CONTAINER - MONTHLY GOALS
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(12.0),

              decoration: BoxDecoration(
                color: const Color(0xFF482616),
                borderRadius: BorderRadius.circular(8.0),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    'Monthly Goals',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF896448),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),

                    const SizedBox(width: 8),

                    const Text(
                      'Save Goals',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
