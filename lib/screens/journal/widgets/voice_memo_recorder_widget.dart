import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../models/voice_memo_item.dart';

class VoiceMemoRecorderWidget extends StatefulWidget {
  final Function(VoiceMemoItem) onRecorded;
  final VoidCallback onCancel;

  const VoiceMemoRecorderWidget({
    super.key,
    required this.onRecorded,
    required this.onCancel,
  });

  @override
  State<VoiceMemoRecorderWidget> createState() => _VoiceMemoRecorderWidgetState();
}

class _VoiceMemoRecorderWidgetState extends State<VoiceMemoRecorderWidget>
    with SingleTickerProviderStateMixin {
  int _secondsElapsed = 0;
  bool _isPaused = false;
  Timer? _timer;
  late AnimationController _pulseController;
  final List<double> _liveWaveform = [];
  final Random _random = Random();
  final TextEditingController _titleController =
      TextEditingController(text: 'Voice Memo');

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    // Seed initial live waveform bars
    for (int i = 0; i < 24; i++) {
      _liveWaveform.add(0.2 + _random.nextDouble() * 0.3);
    }

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && mounted) {
        setState(() {
          _secondsElapsed++;
          // Shift live waveform
          _liveWaveform.removeAt(0);
          _liveWaveform.add(0.2 + _random.nextDouble() * 0.8);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _togglePauseResume() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _pulseController.stop();
      } else {
        _pulseController.repeat(reverse: true);
      }
    });
  }

  void _finishAndSave() {
    _timer?.cancel();
    final durationSec = _secondsElapsed == 0 ? 3 : _secondsElapsed;
    final title = _titleController.text.trim().isEmpty
        ? 'Voice Reflection'
        : _titleController.text.trim();

    final memo = VoiceMemoItem(
      id: 'vm-${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      duration: Duration(seconds: durationSec),
      recordedAt: DateTime.now(),
      waveformSamples: List.from(_liveWaveform),
    );

    widget.onRecorded(memo);
  }

  String _formatTimer() {
    final m = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLight
            ? const Color(0xFFFDECE8)
            : const Color(0xFF2C1E1B),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE05A47).withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Recording Status & Pulse Dot
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _isPaused
                              ? Colors.grey
                              : const Color(0xFFE05A47).withValues(
                                  alpha: 0.5 + (_pulseController.value * 0.5)),
                          shape: BoxShape.circle,
                          boxShadow: _isPaused
                              ? null
                              : [
                                  BoxShadow(
                                    color: const Color(0xFFE05A47).withValues(
                                        alpha: 0.6 * _pulseController.value),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isPaused ? 'RECORDING PAUSED' : 'RECORDING VOICE MEMO...',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: Color(0xFFE05A47),
                    ),
                  ),
                ],
              ),
              Text(
                _formatTimer(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title field for memo
          TextField(
            controller: _titleController,
            style: TextStyle(fontSize: 13, color: AppColors.onSurface),
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Memo Title (e.g. Morning thoughts)...',
              hintStyle: TextStyle(fontSize: 13, color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.surfaceContainerLowest.withValues(alpha: 0.6),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Live Waveform visualizer
          SizedBox(
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _liveWaveform.map((amp) {
                final barH = _isPaused
                    ? 8.0
                    : (amp * 28.0).clamp(4.0, 30.0);
                return Container(
                  width: 5,
                  height: barH,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE05A47).withValues(
                      alpha: _isPaused ? 0.35 : 0.85,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),

          // Action buttons: Cancel, Pause/Resume, Stop & Save
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              TextButton.icon(
                onPressed: widget.onCancel,
                icon: const Icon(Icons.close_rounded, size: 16),
                label: const Text('Cancel', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.onSurfaceVariant,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: _togglePauseResume,
                    icon: Icon(
                      _isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                      color: AppColors.primary,
                    ),
                    tooltip: _isPaused ? 'Resume' : 'Pause',
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton.icon(
                    onPressed: _finishAndSave,
                    icon: const Icon(Icons.check_rounded, size: 16),
                    label: const Text('Attach Memo', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE05A47),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
