import 'mood_item.dart';
import 'voice_memo_item.dart';

class JournalEntry {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final MoodItem mood;
  final List<String> tags;
  final List<String> gratitudeItems;
  final List<String> images;
  final List<VoiceMemoItem> voiceMemos;
  final bool isPinned;

  JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.mood,
    this.tags = const [],
    this.gratitudeItems = const [],
    this.images = const [],
    this.voiceMemos = const [],
    this.isPinned = false,
  });

  JournalEntry copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? date,
    MoodItem? mood,
    List<String>? tags,
    List<String>? gratitudeItems,
    List<String>? images,
    List<VoiceMemoItem>? voiceMemos,
    bool? isPinned,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      tags: tags ?? this.tags,
      gratitudeItems: gratitudeItems ?? this.gratitudeItems,
      images: images ?? this.images,
      voiceMemos: voiceMemos ?? this.voiceMemos,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  static List<JournalEntry> sampleEntries = [
    JournalEntry(
      id: '1',
      title: 'Quiet Morning Thoughts',
      content:
          'Woke up early before dawn. Made a warm cup of coffee and listened to the rain outside. Feeling grateful for a peaceful start to the day and clarity on my priorities.',
      date: DateTime.now().subtract(const Duration(hours: 3)),
      mood: MoodItem.defaultMoods[0], // Calm
      tags: ['Morning', 'Peace', 'Mindfulness'],
      gratitudeItems: ['Warm coffee', 'Gentle rain', 'Quiet headspace'],
      images: [
        'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1518495973542-4542c06a5843?auto=format&fit=crop&w=800&q=80',
      ],
      voiceMemos: [
        VoiceMemoItem(
          id: 'vm-1',
          title: 'Morning Rain & Breathing Exercise',
          duration: const Duration(seconds: 42),
          recordedAt: DateTime.now().subtract(const Duration(hours: 3)),
          waveformSamples: [
            0.2, 0.4, 0.7, 0.5, 0.8, 0.6, 0.9, 0.7, 0.4, 0.6,
            0.8, 0.5, 0.7, 0.9, 0.3, 0.5, 0.8, 0.6, 0.4, 0.2
          ],
        ),
      ],
      isPinned: true,
    ),
    JournalEntry(
      id: '2',
      title: 'Stepping Forward with Focus',
      content:
          'Worked on my career roadmap milestones today. Making small consistent steps every day feels so much better than stressing over the long term.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      mood: MoodItem.defaultMoods[1], // Reflective
      tags: ['Progress', 'Growth'],
      gratitudeItems: ['Consistent progress', 'Good health'],
      images: [
        'https://images.unsplash.com/photo-1499750310107-5fef28a66643?auto=format&fit=crop&w=800&q=80',
      ],
      voiceMemos: [
        VoiceMemoItem(
          id: 'vm-2',
          title: 'Career Milestones Reflection',
          duration: const Duration(minutes: 1, seconds: 15),
          recordedAt: DateTime.now().subtract(const Duration(days: 1)),
          waveformSamples: [
            0.3, 0.6, 0.4, 0.8, 0.7, 0.5, 0.9, 0.8, 0.6, 0.4,
            0.7, 0.5, 0.8, 0.6, 0.9, 0.5, 0.4, 0.6, 0.5, 0.3
          ],
        ),
      ],
    ),
    JournalEntry(
      id: '3',
      title: 'Golden Sunset & Grounding Walk',
      content:
          'Took a 30-minute mindfulness stroll through the park at dusk. The sky turned deep amber and lavender. Reminded myself that rest is productive too.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      mood: MoodItem.defaultMoods[2], // Grateful
      tags: ['Nature', 'Wellbeing', 'Sunset'],
      gratitudeItems: ['Golden hour sunlight', 'Deep breaths', 'Rest'],
      images: [
        'https://images.unsplash.com/photo-1495616811223-4d98c6e9c869?auto=format&fit=crop&w=800&q=80',
      ],
      voiceMemos: [],
    ),
    JournalEntry(
      id: '4',
      title: 'Breakthrough Energy & Workout',
      content:
          'High energy day! Crushed my study session and finished a solid cardio workout. Feeling recharged and ready for tomorrow.',
      date: DateTime.now().subtract(const Duration(days: 4)),
      mood: MoodItem.defaultMoods[3], // Energetic
      tags: ['Workout', 'Study', 'Drive'],
      gratitudeItems: ['Physical energy', 'Clear goals'],
      images: [
        'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=800&q=80',
      ],
      voiceMemos: [
        VoiceMemoItem(
          id: 'vm-3',
          title: 'Post-Workout Thoughts',
          duration: const Duration(seconds: 35),
          recordedAt: DateTime.now().subtract(const Duration(days: 4)),
          waveformSamples: [
            0.5, 0.8, 0.9, 0.7, 0.9, 0.8, 0.6, 0.8, 0.9, 0.7,
            0.8, 0.9, 0.7, 0.6, 0.8, 0.7, 0.5, 0.6, 0.4, 0.3
          ],
        ),
      ],
    ),
  ];
}
