class VoiceMemoItem {
  final String id;
  final String title;
  final Duration duration;
  final DateTime recordedAt;
  final String? audioUri;
  final List<double> waveformSamples;

  const VoiceMemoItem({
    required this.id,
    required this.title,
    required this.duration,
    required this.recordedAt,
    this.audioUri,
    this.waveformSamples = const [
      0.3, 0.5, 0.8, 0.6, 0.9, 0.4, 0.7, 0.3, 0.6, 0.8,
      0.5, 0.7, 0.9, 0.4, 0.6, 0.8, 0.4, 0.3, 0.7, 0.5
    ],
  });

  String get formattedDuration {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'durationMs': duration.inMilliseconds,
      'recordedAt': recordedAt.toIso8601String(),
      'audioUri': audioUri,
      'waveformSamples': waveformSamples,
    };
  }

  factory VoiceMemoItem.fromMap(Map<String, dynamic> map) {
    return VoiceMemoItem(
      id: map['id'] as String,
      title: map['title'] as String,
      duration: Duration(milliseconds: map['durationMs'] as int),
      recordedAt: DateTime.parse(map['recordedAt'] as String),
      audioUri: map['audioUri'] as String?,
      waveformSamples: (map['waveformSamples'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );
  }
}
