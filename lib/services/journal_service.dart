import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../models/mood_item.dart';
import '../models/voice_memo_item.dart';

class JournalService extends ChangeNotifier {
  static final JournalService _instance = JournalService._internal();
  static JournalService get instance => _instance;

  JournalService._internal();

  List<JournalEntry> get entries => JournalEntry.sampleEntries;

  void addEntry(JournalEntry entry) {
    JournalEntry.sampleEntries.insert(0, entry);
    notifyListeners();
  }

  void removeEntry(String id) {
    JournalEntry.sampleEntries.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<JournalEntry> getEntriesForDate(DateTime date) {
    return entries.where((e) => isSameDay(e.date, date)).toList();
  }

  List<String> getImagesForDate(DateTime date) {
    final dayEntries = getEntriesForDate(date);
    final allImages = <String>[];
    for (final entry in dayEntries) {
      allImages.addAll(entry.images);
    }
    return allImages;
  }

  List<VoiceMemoItem> getVoiceMemosForDate(DateTime date) {
    final dayEntries = getEntriesForDate(date);
    final allMemos = <VoiceMemoItem>[];
    for (final entry in dayEntries) {
      allMemos.addAll(entry.voiceMemos);
    }
    return allMemos;
  }

  MoodItem? getDominantMoodForDate(DateTime date) {
    final dayEntries = getEntriesForDate(date);
    if (dayEntries.isEmpty) return null;
    return dayEntries.first.mood;
  }

  Map<int, List<JournalEntry>> getEntriesGroupedByDay(int year, int month) {
    final map = <int, List<JournalEntry>>{};
    for (final entry in entries) {
      if (entry.date.year == year && entry.date.month == month) {
        map.putIfAbsent(entry.date.day, () => []).add(entry);
      }
    }
    return map;
  }
}
