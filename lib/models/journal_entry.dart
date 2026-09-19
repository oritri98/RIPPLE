import 'mood_item.dart';

class JournalEntry {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final MoodItem mood;
  final List<String> tags;
  final List<String> gratitudeItems;

  JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.mood,
    this.tags = const [],
    this.gratitudeItems = const [],
  });

  static List<JournalEntry> sampleEntries = [
    JournalEntry(
      id: '1',
      title: 'Quiet Morning Thoughts',
      content: 'Woke up early before dawn. Made a warm cup of coffee and listened to the rain outside. Feeling grateful for a peaceful start to the day and clarity on my priorities.',
      date: DateTime.now().subtract(const Duration(hours: 4)),
      mood: MoodItem.defaultMoods[0], // Calm
      tags: ['Morning', 'Peace', 'Mindfulness'],
      gratitudeItems: ['Warm coffee', 'Gentle rain', 'Quiet headspace'],
    ),
    JournalEntry(
      id: '2',
      title: 'Stepping Forward with Focus',
      content: 'Worked on my career roadmap milestones today. Making small consistent steps every day feels so much better than stressing over the long term.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      mood: MoodItem.defaultMoods[1], // Reflective
      tags: ['Progress', 'Growth'],
      gratitudeItems: ['Consistent progress', 'Good health'],
    ),
  ];
}
