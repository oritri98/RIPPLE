import 'package:flutter/material.dart';

class AiInsightReport {
  final String overallSummary;
  final String emotionalTrajectory; // e.g. "Improving ↗", "Fluctuating 〰", "Dipping ↘", "Grounded & Stable 🌿"
  final String trajectoryDescription;
  final List<String> growthMilestones;
  final List<String> downfallVulnerabilities;
  final String dominantMood;
  final String mindfulRecommendation;
  final DateTime analyzedAt;
  final int entriesAnalyzedCount;

  const AiInsightReport({
    required this.overallSummary,
    required this.emotionalTrajectory,
    required this.trajectoryDescription,
    required this.growthMilestones,
    required this.downfallVulnerabilities,
    required this.dominantMood,
    required this.mindfulRecommendation,
    required this.analyzedAt,
    required this.entriesAnalyzedCount,
  });

  Color get trajectoryColor {
    final lower = emotionalTrajectory.toLowerCase();
    if (lower.contains('improv') || lower.contains('up') || lower.contains('growth')) {
      return const Color(0xFF81B29A); // Gentle sage green
    } else if (lower.contains('dip') || lower.contains('down') || lower.contains('fall')) {
      return const Color(0xFFE07A5F); // Warm terracotta / alert
    } else if (lower.contains('fluct')) {
      return const Color(0xFFFEC486); // Honey amber
    }
    return const Color(0xFF0071E3); // Electric azure / calm
  }

  Map<String, dynamic> toMap() {
    return {
      'overallSummary': overallSummary,
      'emotionalTrajectory': emotionalTrajectory,
      'trajectoryDescription': trajectoryDescription,
      'growthMilestones': growthMilestones,
      'downfallVulnerabilities': downfallVulnerabilities,
      'dominantMood': dominantMood,
      'mindfulRecommendation': mindfulRecommendation,
      'analyzedAt': analyzedAt.toIso8601String(),
      'entriesAnalyzedCount': entriesAnalyzedCount,
    };
  }

  factory AiInsightReport.fromMap(Map<String, dynamic> map) {
    return AiInsightReport(
      overallSummary: map['overallSummary'] as String? ??
          'Your reflections show steady introspection and emotional balance.',
      emotionalTrajectory:
          map['emotionalTrajectory'] as String? ?? 'Grounded & Stable 🌿',
      trajectoryDescription: map['trajectoryDescription'] as String? ??
          'Balanced mood rhythm with healthy self-reflection.',
      growthMilestones: (map['growthMilestones'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      downfallVulnerabilities:
          (map['downfallVulnerabilities'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
      dominantMood: map['dominantMood'] as String? ?? 'Calm 🌿',
      mindfulRecommendation: map['mindfulRecommendation'] as String? ??
          'Begin tomorrow morning with 5 minutes of quiet breathing.',
      analyzedAt: map['analyzedAt'] != null
          ? DateTime.parse(map['analyzedAt'] as String)
          : DateTime.now(),
      entriesAnalyzedCount: map['entriesAnalyzedCount'] as int? ?? 1,
    );
  }

  static AiInsightReport sampleReport() {
    return AiInsightReport(
      overallSummary:
          'Across your recent reflections, your emotional trajectory shows a positive rebound. Early career anxieties and stress were effectively counterbalanced by mindful outdoor strolls, gratitude check-ins, and consistent morning rituals.',
      emotionalTrajectory: 'Improving ↗',
      trajectoryDescription:
          'Positive upward trend detected after stepping back from overthinking and engaging in physical movement.',
      growthMilestones: [
        'Resilience breakthrough: You consciously chose rest and a park walk instead of spiraling over career deadlines.',
        'Morning intentionality: Quiet coffee and mindful audio listening grounded your headspace before working.',
        'Gratitude consistency: You logged 8 specific gratitude moments across 3 days, increasing overall calm.',
      ],
      downfallVulnerabilities: [
        'Career pressure trigger: Late-evening thoughts showed recurring anxiety around long-term milestones.',
        'Fatigue pattern: Days with high mental workloads correlated with dips in evening patience.',
      ],
      dominantMood: 'Reflective ✨',
      mindfulRecommendation:
          'Tomorrow morning, protect your first 15 minutes: sip your coffee without checking task lists or career roadmaps.',
      analyzedAt: DateTime.now(),
      entriesAnalyzedCount: 4,
    );
  }
}
