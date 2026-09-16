import 'package:flutter/material.dart';
import 'stage1.dart'; // 1. Import your new file here

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StageSelectionPage(), // 2. Tell the app to show your new page
    );
  }
}