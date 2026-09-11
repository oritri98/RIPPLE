import 'package:flutter/material.dart';

/// MoodItem represents an emotional check-in option.
/// 
/// BEGINNER TIP:
/// We bundle the name, icon, and description together so we can
/// easily loop through a list of moods and display them on screen!
class MoodItem {
  final String name;
  final IconData icon;
  final String description;

  const MoodItem({
    required this.name,
    required this.icon,
    required this.description,
  });
}
