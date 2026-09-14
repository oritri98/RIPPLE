
import 'package:flutter/material.dart';

class PrioritySelection extends StatefulWidget {
  const PrioritySelection({super.key});

  @override
  State<PrioritySelection> createState() => _PrioritySelectionState();
}
bool isSelected = false;
bool isSelected2 = false;
bool isSelected3 = false;

class _PrioritySelectionState extends State<PrioritySelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

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
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'You can change later in settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),
            
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                  isSelected2 = false;
                  isSelected3 = false;
                });
              },
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.teal : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                 
                  child: Text(
                    'Health',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // First box
           

            const SizedBox(height: 10),

           
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = false;
                  isSelected2 = true;
                  isSelected3 = false;
                });
              },
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: isSelected2 ? Colors.teal : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                 
                  child: Text(
                    'Health',
                    style: TextStyle(
                      color: isSelected2 ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // First box
           

            const SizedBox(height: 10),

            // Third box
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(height: 10),

            // Third box
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            

            const SizedBox(height: 80),

            Container(
              width: double.infinity,
              height: 80,
              color: Colors.teal,
              child: Center(
                child: Text(
                  'Customize Your Goals',
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
             
            ),
            ),
            const SizedBox(height: 10),

            SizedBox(height: 20),
                 
                 SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text('Save Priority'),
                  ),
                 
                 )
          
          ],
        ),
      ),
    );
  }
}




