import 'package:flutter/material.dart';

class PrioritySelection extends StatefulWidget {
  const PrioritySelection({super.key});

  @override
  State<PrioritySelection> createState() => _PrioritySelectionState();
}

bool isSelected = false;
bool isSelected2 = false;
bool isSelected3 = false;
bool isSelected4 = false;

class _PrioritySelectionState extends State<PrioritySelection> {
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
              'What are Your Priorities?',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 250, 252, 251),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'You can change later in settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF896448),
              ),
            ),

            const SizedBox(height: 20),

            // FIRST BOX
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                  isSelected2 = false;
                  isSelected3 = false;
                  isSelected4 = false;
                });
              },
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF896448)
                      : const Color(0xFF482616),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'Health',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // SECOND BOX
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = false;
                  isSelected2 = !isSelected2;
                  isSelected3 = false;
                  isSelected4 = false;
                });
              },
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: isSelected2
                      ? const Color(0xFF896448)
                      : const Color(0xFF482616),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'Career',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // THIRD BOX
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = false;
                  isSelected2 = false;
                  isSelected3 = !isSelected3;
                  isSelected4 = false;
                });
              },
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: isSelected3
                      ? const Color(0xFF896448)
                      : const Color(0xFF482616),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'Finance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // FOURTH BOX
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = false;
                  isSelected2 = false;
                  isSelected3 = false;
                  isSelected4 = !isSelected4;
                });
              },
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: isSelected4
                      ? const Color(0xFF896448)
                      : const Color(0xFF482616),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'Personal Growth',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 80),

            // CUSTOMIZE GOALS
            Container(
              width: double.infinity,
              height: 80,
             
              color: const Color.fromARGB(255, 39, 26, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),

                  const Icon(Icons.stars, color: Colors.white),

                  const SizedBox(width: 10),

                  const Text(
                    'Can\'t find your priority?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 140),

                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF896448),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Custom Goal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 249, 249, 249),
                        ),
                      ),
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
                child: const Text(
                  'Save Priority',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
