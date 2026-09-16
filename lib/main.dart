import 'package:flutter/material.dart';
import 'stage1.dart'; // Import new file (1st jeita ashbe)

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StageSelectionPage(), //show new page (1st one called)
    );
  }
}