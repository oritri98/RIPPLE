import 'package:flutter/material.dart';
//import 'priorityselection.dart';
//import 'home_screen.dart';
//import 'educationselection.dart';
//import 'add_goal_screen.dart';
//import 'set_goals_screen.dart';
//import 'timeline_screen.dart';
//import 'loginpage.dart';
//import 'addnewgoal.dart';
import 'insightscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ripple',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF14100E),
      ),
      
     // home: const PrioritySelection(), // App starts here first
    // home : const AddNewGoal(),
      // App starts here first
      // home : const Loginpage(),
      //home : const EducationSelection(),
      home : const InsightScreen(),
      
    );
  }
}

