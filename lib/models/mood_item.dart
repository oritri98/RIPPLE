import 'package:flutter/material.dart';

class MoodItem {
  final String label;
  final String emoji;
  final Color color;

  const MoodItem({
    required this.label,
    required this.emoji,
    required this.color,
  });

  static const List<MoodItem> defaultMoods = [
    MoodItem(label: 'Calm', emoji: '🌿', color: Color(0xFF81B29A)),
    MoodItem(label: 'Reflective', emoji: '✨', color: Color(0xFFFEC486)),
    MoodItem(label: 'Grateful', emoji: '💛', color: Color(0xFFFFB689)),
    MoodItem(label: 'Energetic', emoji: '⚡', color: Color(0xFFE0A96D)),
    MoodItem(label: 'Anxious', emoji: '🌊', color: Color(0xFF9D8E81)),
  ];
}
