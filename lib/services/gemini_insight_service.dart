import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/ai_insight_report.dart';
import '../models/journal_entry.dart';

class GeminiInsightService extends ChangeNotifier {
  static final GeminiInsightService _instance = GeminiInsightService._internal();
  static GeminiInsightService get instance => _instance;

  GeminiInsightService._internal() {
    _currentReport = AiInsightReport.sampleReport();
  }

  String? _apiKey;
  AiInsightReport? _currentReport;
  bool _isLoading = false;
  String? _errorMessage;

  String? get apiKey => _apiKey;
  bool get hasApiKey => _apiKey != null && _apiKey!.isNotEmpty;
  AiInsightReport? get currentReport => _currentReport;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  static String sanitizeKey(String raw) {
    return raw
        .replaceAll(RegExp(r'[\r\n\t\s\u00A0\u200B\u200C\u200D\uFEFF]'), '')
        .replaceAll('"', '')
        .replaceAll("'", '')
        .replaceAll('`', '')
        .trim();
  }

  void setApiKey(String key) {
    _apiKey = sanitizeKey(key);
    _errorMessage = null;
    notifyListeners();
  }

  void clearApiKey() {
    _apiKey = null;
    notifyListeners();
  }

  /// Verifies if a given Gemini API key is valid by sending a 1-token test ping.
  Future<Map<String, dynamic>> testKeyConnection(String key) async {
    final cleanKey = sanitizeKey(key);
    if (cleanKey.isEmpty) {
      return {'success': false, 'message': 'API key is empty.'};
    }
    if (!cleanKey.startsWith('AIzaSy')) {
      return {
        'success': false,
        'message': 'Key format issue: Gemini API keys normally begin with "AIzaSy". Please check you did not copy a project name or ID.',
      };
    }

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$cleanKey',
    );

    final requestBody = jsonEncode({
      'contents': [
        {
          'parts': [
            {'text': 'Hello'}
          ]
        }
      ],
      'generationConfig': {'maxOutputTokens': 5}
    });

    final client = HttpClient();
    try {
      final request = await client.postUrl(url);
      request.headers.set('Content-Type', 'application/json');
      request.headers.set('x-goog-api-key', cleanKey);
      request.write(requestBody);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Connected to Gemini 1.5 Flash successfully! ✨',
        };
      } else {
        String serverMsg = 'Status code ${response.statusCode}';
        try {
          final errJson = jsonDecode(responseBody);
          serverMsg = errJson['error']?['message'] ?? serverMsg;
        } catch (_) {}

        if (serverMsg.contains('API key not valid')) {
          return {
            'success': false,
            'message': 'Google reported: API key not valid. Please ensure you copied your key from Google AI Studio (aistudio.google.com).',
          };
        }
        return {'success': false, 'message': serverMsg};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    } finally {
      client.close();
    }
  }

  /// Generates emotional growth and downfall insights from journal entries.
  Future<AiInsightReport> generateInsights(
    List<JournalEntry> entries, {
    String? customKey,
  }) async {
    final keyToUse = (customKey != null && customKey.trim().isNotEmpty)
        ? sanitizeKey(customKey)
        : _apiKey;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (entries.isEmpty) {
        throw Exception('Please write at least one journal entry first.');
      }

      // If no API key provided, generate a heuristic offline report
      if (keyToUse == null || keyToUse.isEmpty) {
        await Future.delayed(const Duration(milliseconds: 700));
        final offlineReport = _generateLocalHeuristicReport(entries);
        _currentReport = offlineReport;
        _isLoading = false;
        notifyListeners();
        return offlineReport;
      }

      // Prepare prompt payload for Gemini
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
      'Respond ONLY in valid, raw JSON (no markdown formatting, no conversational text) matching this schema:\n'
      '{\n'
      '  "overallSummary": "Narrative 2-3 sentence overview of their emotional arc and psychological theme",\n'
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
    final cleanKey = sanitizeKey(apiKey);
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$cleanKey',
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
      request.headers.set('x-goog-api-key', cleanKey);
      request.write(requestBody);

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode != 200) {
        String errorMsg = 'Error (${response.statusCode})';
        try {
          final errorJson = jsonDecode(responseBody);
          errorMsg = errorJson['error']?['message'] ?? errorMsg;
        } catch (_) {}

        if (errorMsg.contains('API key not valid')) {
          throw Exception(
            'API key is not valid. Please ensure you copied your key from Google AI Studio (aistudio.google.com).',
          );
        }
        throw Exception('Gemini: $errorMsg');
      }

      final jsonResponse = jsonDecode(responseBody);
      final textContent =
          jsonResponse['candidates']?[0]?['content']?['parts']?[0]?['text'];

      if (textContent == null || textContent.toString().trim().isEmpty) {
        throw Exception('Gemini generated an empty response.');
      }

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
      topMood =
          moodCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
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
