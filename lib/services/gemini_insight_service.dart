import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/ai_insight_report.dart';
import '../models/journal_entry.dart';

class GeminiInsightService extends ChangeNotifier {
  static final GeminiInsightService _instance = GeminiInsightService._internal();
  static GeminiInsightService get instance => _instance;

  GeminiInsightService._internal() {
    // Provide an initial sample report so the user sees the feature in action immediately
    _currentReport = AiInsightReport.sampleReport();
  }

  String? _apiKey;
  AiInsightReport? _currentReport;
  bool _isLoading = false;
  String? _errorMessage;

  String? get apiKey => _apiKey;
  bool get hasApiKey => _apiKey != null && _apiKey!.trim().isNotEmpty;
  AiInsightReport? get currentReport => _currentReport;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setApiKey(String key) {
    _apiKey = key.trim();
    _errorMessage = null;
    notifyListeners();
  }

  void clearApiKey() {
    _apiKey = null;
    notifyListeners();
  }

  /// Generates emotional growth and downfall insights from journal entries.
  /// If [customKey] is provided, it uses it; otherwise uses the stored [_apiKey].
  Future<AiInsightReport> generateInsights(
    List<JournalEntry> entries, {
    String? customKey,
  }) async {
    final keyToUse = (customKey != null && customKey.trim().isNotEmpty)
        ? customKey.trim()
        : _apiKey;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (entries.isEmpty) {
        throw Exception('Please add at least one journal reflection before generating AI insights.');
      }

      // If no API key provided, generate a heuristic offline report
      if (keyToUse == null || keyToUse.isEmpty) {
        await Future.delayed(const Duration(milliseconds: 900)); // Smooth UI transition
        final offlineReport = _generateLocalHeuristicReport(entries);
        _currentReport = offlineReport;
        _isLoading = false;
        notifyListeners();
        return offlineReport;
      }

      // Prepare prompt payload for Gemini 1.5 Flash
      final promptText = _buildPrompt(entries);
      final report = await _callGeminiApi(promptText, keyToUse, entries.length);

      _currentReport = report;
      _isLoading = false;
      notifyListeners();
      return report;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  String _buildPrompt(List<JournalEntry> entries) {
    final buffer = StringBuffer();
    buffer.writeln(
      'You are Ripple AI, an empathetic cognitive psychologist and emotional growth analyst. '
      'Analyze the user\'s chronological journal reflections below.\n'
      'Detect patterns of emotional growth, resilience, healthy coping habits, as well as '
      'emotional downfalls, dips, stress triggers, or fatigue patterns. '
      'Respond ONLY in valid, raw JSON (no additional conversational text) using this exact schema:\n'
      '{\n'
      '  "overallSummary": "Narrative 2-3 sentence overview of their trajectory and psychological theme",\n'
      '  "emotionalTrajectory": "Improving ↗ OR Fluctuating 〰 OR Dipping ↘ OR Grounded & Stable 🌿",\n'
      '  "trajectoryDescription": "1 sentence explaining why this trajectory was determined",\n'
      '  "growthMilestones": [\n'
      '    "Specific self-awareness or resilience breakthrough from the entries",\n'
      '    "Another positive habit or growth moment"\n'
      '  ],\n'
      '  "downfallVulnerabilities": [\n'
      '    "Specific emotional trigger or fatigue pattern detected in the entries",\n'
      '    "Another vulnerability or dip to be mindful of"\n'
      '  ],\n'
      '  "dominantMood": "Most prevalent mood and emoji",\n'
      '  "mindfulRecommendation": "1 concrete micro-actionable habit for tomorrow personalized to their reflections"\n'
      '}\n\n'
      'USER JOURNAL ENTRIES (Chronological):\n'
    );

    for (int i = 0; i < entries.length; i++) {
      final e = entries[i];
      buffer.writeln(
        '--- Entry #${i + 1} (${e.date.year}-${e.date.month}-${e.date.day}) ---\n'
        'Title: ${e.title}\n'
        'Mood: ${e.mood.label} ${e.mood.emoji}\n'
        'Reflection: ${e.content}\n'
        'Gratitudes: ${e.gratitudeItems.join(", ")}\n'
        'Has Voice Memo: ${e.voiceMemos.isNotEmpty}\n'
        'Has Photo: ${e.images.isNotEmpty}\n'
      );
    }

    return buffer.toString();
  }

  Future<AiInsightReport> _callGeminiApi(
    String prompt,
    String apiKey,
    int entriesCount,
  ) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey',
    );

    final requestBody = jsonEncode({
      'contents': [
        {
          'parts': [
            {'text': prompt}
          ]
        }
      ],
      'generationConfig': {
        'temperature': 0.7,
        'responseMimeType': 'application/json',
      }
    });

    final client = HttpClient();
    try {
      final request = await client.postUrl(url);
      request.headers.set('Content-Type', 'application/json');
      request.write(requestBody);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(responseBody);
        final message = errorJson['error']?['message'] ?? 'API error (${response.statusCode})';
        throw Exception('Gemini API Error: $message');
      }

      final jsonResponse = jsonDecode(responseBody);
      final textContent = jsonResponse['candidates']?[0]?['content']?['parts']?[0]?['text'];

      if (textContent == null || textContent.toString().trim().isEmpty) {
        throw Exception('No response generated by Gemini model.');
      }

      // Clean potential markdown wrap
      String cleanedJson = textContent.toString().trim();
      if (cleanedJson.startsWith('```json')) {
        cleanedJson = cleanedJson.substring(7);
      } else if (cleanedJson.startsWith('```')) {
        cleanedJson = cleanedJson.substring(3);
      }
      if (cleanedJson.endsWith('```')) {
        cleanedJson = cleanedJson.substring(0, cleanedJson.length - 3);
      }
      cleanedJson = cleanedJson.trim();

      final parsed = jsonDecode(cleanedJson) as Map<String, dynamic>;
      parsed['analyzedAt'] = DateTime.now().toIso8601String();
      parsed['entriesAnalyzedCount'] = entriesCount;

      return AiInsightReport.fromMap(parsed);
    } finally {
      client.close();
    }
  }

  AiInsightReport _generateLocalHeuristicReport(List<JournalEntry> entries) {
    final moodCounts = <String, int>{};
    int gratitudeCount = 0;
    for (final e in entries) {
      moodCounts[e.mood.label] = (moodCounts[e.mood.label] ?? 0) + 1;
      gratitudeCount += e.gratitudeItems.length;
    }

    String topMood = 'Calm 🌿';
    if (moodCounts.isNotEmpty) {
      final dominantKey =
          moodCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
      topMood = dominantKey;
    }

    return AiInsightReport(
      overallSummary:
          'Based on your ${entries.length} reflections, your emotional patterns show conscious self-awareness. Gratitude check-ins are acting as an emotional anchor during busy days.',
      emotionalTrajectory: 'Grounded & Stable 🌿',
      trajectoryDescription:
          'Consistent mindfulness habit detected with regular gratitude entries balancing daily stress.',
      growthMilestones: [
        'Mindful consistency: You logged $gratitudeCount gratitude items, reinforcing positive emotional reframing.',
        'Intention tracking: Reflections indicate proactive focus on personal priorities.',
      ],
      downfallVulnerabilities: [
        'Watch for busy days: Reflection gaps often coincide with higher cognitive strain.',
        'Evening mental fatigue: Consider winding down screen time earlier to avoid overthinking.',
      ],
      dominantMood: topMood,
      mindfulRecommendation:
          'Set a 5-minute pause tomorrow afternoon to breathe deeply and reflect before starting your final tasks.',
      analyzedAt: DateTime.now(),
      entriesAnalyzedCount: entries.length,
    );
  }
}
