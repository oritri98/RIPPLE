import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/journal_entry.dart';
import '../models/mood_item.dart';
import '../models/voice_memo_item.dart';

class JournalService extends ChangeNotifier {
  static final JournalService _instance = JournalService._internal();
  static JournalService get instance => _instance;

  JournalService._internal() {
    _entries.addAll(JournalEntry.sampleEntries);
  }

  static const String _storageKey = 'ripple_journal_entries_v1';
  static const int maxPinnedEntries = 5;

  SharedPreferences? _prefs;
  final List<JournalEntry> _entries = [];

  List<JournalEntry> get entries {
    final list = List<JournalEntry>.from(_entries);
    list.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.date.compareTo(a.date);
    });
    return list;
  }

  int get pinnedCount => _entries.where((e) => e.isPinned).length;

  bool isPinned(String id) {
    for (final e in _entries) {
      if (e.id == id) return e.isPinned;
    }
    return false;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final jsonStr = _prefs?.getString(_storageKey);
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        final decoded = jsonDecode(jsonStr) as List<dynamic>;
        _entries.clear();
        for (final item in decoded) {
          _entries.add(JournalEntry.fromMap(item as Map<String, dynamic>));
        }
        notifyListeners();
        return;
      } catch (e) {
        debugPrint('Error loading saved journal entries: $e');
      }
    }

    // First time run or empty storage: keep default sample entries and persist them
    if (_entries.isEmpty) {
      _entries.addAll(JournalEntry.sampleEntries);
    }
    _saveToStorage();
    notifyListeners();
  }

  Future<void> _saveToStorage() async {
    if (_prefs == null) return;
    try {
      final list = _entries.map((e) => e.toMap()).toList();
      await _prefs!.setString(_storageKey, jsonEncode(list));
    } catch (e) {
      debugPrint('Error saving journal entries to storage: $e');
    }
  }

  /// Toggles pin state. Returns true if toggle succeeded, false if max limit of 5 is reached.
  bool togglePin(String id) {
    final index = _entries.indexWhere((e) => e.id == id);
    if (index == -1) return false;
    final current = _entries[index];
    if (!current.isPinned && pinnedCount >= maxPinnedEntries) {
      return false; // Limit of 5 pinned entries reached
    }
    _entries[index] = current.copyWith(isPinned: !current.isPinned);
    _saveToStorage();
    notifyListeners();
    return true;
  }

  void addEntry(JournalEntry entry) {
    _entries.insert(0, entry);
    _saveToStorage();
    notifyListeners();
  }

  JournalEntry? removeEntry(String id) {
    final index = _entries.indexWhere((e) => e.id == id);
    if (index == -1) return null;
    final removed = _entries.removeAt(index);
    _saveToStorage();
    notifyListeners();
    return removed;
  }

  void restoreEntry(JournalEntry entry, [int? index]) {
    if (index != null && index >= 0 && index <= _entries.length) {
      _entries.insert(index, entry);
    } else {
      _entries.insert(0, entry);
    }
    _saveToStorage();
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
