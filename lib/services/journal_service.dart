import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../models/mood_item.dart';
import '../models/voice_memo_item.dart';

class JournalService extends ChangeNotifier {
  static final JournalService _instance = JournalService._internal();
  static JournalService get instance => _instance;

  JournalService._internal();

  static const int maxPinnedEntries = 5;

  List<JournalEntry> get entries {
    final list = List<JournalEntry>.from(JournalEntry.sampleEntries);
    list.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.date.compareTo(a.date);
    });
    return list;
  }

  int get pinnedCount =>
      JournalEntry.sampleEntries.where((e) => e.isPinned).length;

  bool isPinned(String id) {
    for (final e in JournalEntry.sampleEntries) {
      if (e.id == id) return e.isPinned;
    }
    return false;
  }

  /// Toggles pin state. Returns true if toggle succeeded, false if max limit of 5 is reached.
  bool togglePin(String id) {
    final index = JournalEntry.sampleEntries.indexWhere((e) => e.id == id);
    if (index == -1) return false;
    final current = JournalEntry.sampleEntries[index];
    if (!current.isPinned && pinnedCount >= maxPinnedEntries) {
      return false; // Limit of 5 pinned entries reached
    }
    JournalEntry.sampleEntries[index] =
        current.copyWith(isPinned: !current.isPinned);
    notifyListeners();
    return true;
  }

  void addEntry(JournalEntry entry) {
    JournalEntry.sampleEntries.insert(0, entry);
    notifyListeners();
  }

  JournalEntry? removeEntry(String id) {
    final index = JournalEntry.sampleEntries.indexWhere((e) => e.id == id);
    if (index == -1) return null;
    final removed = JournalEntry.sampleEntries.removeAt(index);
    notifyListeners();
    return removed;
  }

  void restoreEntry(JournalEntry entry, [int? index]) {
    if (index != null &&
        index >= 0 &&
        index <= JournalEntry.sampleEntries.length) {
      JournalEntry.sampleEntries.insert(index, entry);
    } else {
      JournalEntry.sampleEntries.insert(0, entry);
    }
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
