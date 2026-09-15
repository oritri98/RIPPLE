import 'package:flutter/material.dart';

class AddNewGoal extends StatefulWidget {
  const AddNewGoal({super.key});

  @override
  State<AddNewGoal> createState() => _AddNewGoalState();
}

class _AddNewGoalState extends State<AddNewGoal> {
  final TextEditingController goalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 12, 12),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 12, 12),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Daily Goals',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const Text(
                'Track your progress. One step at a time.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              
              Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 29, 27),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: Colors.white,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Today's Overview",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 109, 76, 65),
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          Column(
                            children: const [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),

                                  SizedBox(width: 5),

                                  Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 5),

                              Text(
                                'Completed',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: const [
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle_outlined,
                                    color: Colors.orange,
                                  ),

                                  SizedBox(width: 5),

                                  Text(
                                    '2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 5),

                              Text(
                                'In Progress',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: const [
                              Row(
                                children: [
                                  Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                  ),

                                  SizedBox(width: 5),

                                  Text(
                                    '2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 5),

                              Text(
                                'Not Completed',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: const [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),

                                  SizedBox(width: 5),

                                  Text(
                                    '60%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 5),

                              Text(
                                'Overall Progress',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

             
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 208, 142, 130),
                      borderRadius: BorderRadius.circular(25),
                    ),

                    child: const Text(
                      'All',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 20, 18, 17),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),

                    child: const Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 20,
                        ),

                        SizedBox(width: 5),

                        Text(
                          'Completed',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 20, 18, 17),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),

                    child: const Row(
                      children: [
                        Icon(
                          Icons.circle_outlined,
                          color: Colors.orange,
                          size: 20,
                        ),

                        SizedBox(width: 5),

                        Text(
                          'In Progress',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 20, 18, 17),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),

                    child: const Row(
                      children: [
                        Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                          size: 20,
                        ),

                        SizedBox(width: 5),

                        Text(
                          'Not Completed',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                height: 100,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 29, 27),
                ),

                child: Row(
                  children: [
                    const SizedBox(width: 15),

                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 38,
                    ),

                    const SizedBox(width: 15),

                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Read for 30 minutes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),

                        SizedBox(height: 7),

                        Row(
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              color: Colors.grey,
                              size: 16,
                            ),

                            SizedBox(width: 5),

                            Text(
                              'Personal Growth',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: const Color.fromARGB(30, 100, 150, 80),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                  ],
                ),
              ),

              const SizedBox(height: 7),

              Container(
                width: double.infinity,
                height: 100,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 29, 27),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [
                    const SizedBox(width: 15),

                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 38,
                    ),

                    const SizedBox(width: 15),

                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Drink 8 glasses of water',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),

                        SizedBox(height: 7),

                        Row(
                          children: [
                            Icon(
                              Icons.water_drop_outlined,
                              color: Colors.grey,
                              size: 16,
                            ),

                            SizedBox(width: 5),

                            Text(
                              'Health',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: const Color.fromARGB(30, 100, 150, 80),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Text(
                        'Completed',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                height: 100,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 29, 27),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [
                    const SizedBox(width: 15),

                    const Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                      size: 38,
                    ),

                    const SizedBox(width: 15),

                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'No sugar / junk food',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),

                        SizedBox(height: 7),

                        Row(
                          children: [
                            Icon(
                              Icons.eco_outlined,
                              color: Colors.grey,
                              size: 16,
                            ),

                            SizedBox(width: 5),

                            Text(
                              'Health',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: const Color.fromARGB(30, 150, 60, 60),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Text(
                        'Not Completed',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                  ],
                ),
              ),

              const SizedBox(height: 7),

              Container(
                width: double.infinity,
                height: 100,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 29, 27),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [
                    const SizedBox(width: 15),

                    const Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                      size: 38,
                    ),

                    const SizedBox(width: 15),

                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Work on side project',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),

                        SizedBox(height: 7),

                        Row(
                          children: [
                            Icon(
                              Icons.laptop_outlined,
                              color: Colors.grey,
                              size: 16,
                            ),

                            SizedBox(width: 5),

                            Text(
                              'Personal Growth',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: const Color.fromARGB(30, 150, 60, 60),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Text(
                        'Not Completed',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                  ],
                ),
              ),

              const SizedBox(height: 7),

              // =================================================
              // GOAL 6
              // =================================================
              Container(
                width: double.infinity,
                height: 110,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 29, 27),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [
                    const SizedBox(width: 15),

                    const Icon(
                      Icons.circle_outlined,
                      color: Colors.orange,
                      size: 38,
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            'Meditate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),

                          const SizedBox(height: 7),

                          const Row(
                            children: [
                              Icon(
                                Icons.spa_outlined,
                                color: Colors.grey,
                                size: 16,
                              ),

                              SizedBox(width: 5),

                              Text(
                                'Mindfulness',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          LinearProgressIndicator(
                            value: 0.5,
                            minHeight: 6,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Text(
                      '5 / 10 min',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(width: 10),
                  ],
                ),
              ),

              const SizedBox(height: 7),

              // =================================================
              // ADD NEW GOAL
              // =================================================
              Container(
                width: double.infinity,
                height: 90,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 29, 27),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [
                    const SizedBox(width: 15),

                    Container(
                      width: 40,
                      height: 40,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Add New Goal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Tap to add a new daily goal',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 10),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 85,

        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 21, 18, 17),

          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: const [
                Icon(
                  Icons.wb_sunny_outlined,
                  color: Color.fromARGB(255, 255, 214, 154),
                  size: 25,
                ),

                SizedBox(height: 5),

                Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ],
            ),

            // JOURNAL
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: const [
                Icon(
                  Icons.menu_book_outlined,
                  color: Colors.grey,
                  size: 25,
                ),

                SizedBox(height: 5),

                Text(
                  'Journal',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),

            // EMPTY SPACE FOR BUTTON
            const SizedBox(width: 55),

            // TASKS
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: const [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                  size: 25,
                ),

                SizedBox(height: 5),

                Text(
                  'Tasks',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),

            // INSIGHTS
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: const [
                Icon(
                  Icons.insights_outlined,
                  color: Colors.grey,
                  size: 25,
                ),

                SizedBox(height: 5),

                Text(
                  'Insights',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // ==========================================================
      // PENCIL BUTTON
      // ==========================================================
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 194, 125),

        onPressed: () {},

        child: const Icon(
          Icons.edit,
          color: Color.fromARGB(255, 90, 47, 11),
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
    );
  }
}