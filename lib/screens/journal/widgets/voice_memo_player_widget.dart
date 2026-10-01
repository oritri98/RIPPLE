import 'dart:async';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../models/voice_memo_item.dart';

class VoiceMemoPlayerWidget extends StatefulWidget {
  final VoiceMemoItem memo;
  final VoidCallback? onDelete;
  final bool compact;

  const VoiceMemoPlayerWidget({
    super.key,
    required this.memo,
    this.onDelete,
    this.compact = false,
  });

  @override
  State<VoiceMemoPlayerWidget> createState() => _VoiceMemoPlayerWidgetState();
}

class _VoiceMemoPlayerWidgetState extends State<VoiceMemoPlayerWidget>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  double _playbackProgress = 0.0; // 0.0 to 1.0
  double _playbackSpeed = 1.0;
  Timer? _playbackTimer;
  late AnimationController _waveAnimController;

  @override
  void initState() {
    super.initState();
    _waveAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    _waveAnimController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _pausePlayback();
    } else {
      _startPlayback();
    }
  }

  void _startPlayback() {
    if (_playbackProgress >= 1.0) {
      _playbackProgress = 0.0;
    }
    setState(() {
      _isPlaying = true;
    });
    _waveAnimController.repeat(reverse: true);

    final totalSeconds = widget.memo.duration.inSeconds.toDouble().clamp(1.0, 3600.0);
    const intervalMs = 100;
    final increment = (intervalMs / 1000) * _playbackSpeed / totalSeconds;

    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(milliseconds: intervalMs), (timer) {
      if (!mounted) return;
      setState(() {
        _playbackProgress += increment;
        if (_playbackProgress >= 1.0) {
          _playbackProgress = 1.0;
          _pausePlayback();
        }
      });
    });
  }

  void _pausePlayback() {
    _playbackTimer?.cancel();
    _waveAnimController.stop();
    if (mounted) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  void _cycleSpeed() {
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 1.5;
      } else if (_playbackSpeed == 1.5) {
        _playbackSpeed = 2.0;
      } else {
        _playbackSpeed = 1.0;
      }
    });
    if (_isPlaying) {
      _startPlayback();
    }
  }

  String _formatElapsed() {
    final currentSeconds =
        (_playbackProgress * widget.memo.duration.inSeconds).round();
    final m = (currentSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (currentSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight;
    final samples = widget.memo.waveformSamples;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(
        horizontal: widget.compact ? 12 : 16,
        vertical: widget.compact ? 10 : 12,
      ),
      decoration: BoxDecoration(
        color: isLight
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.surfaceContainerHigh.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _isPlaying
              ? AppColors.primary.withValues(alpha: 0.6)
              : (isLight ? AppColors.primary.withValues(alpha: 0.2) : Colors.white12),
          width: _isPlaying ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Title & Optional Delete Button
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mic_rounded,
                  size: 14,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.memo.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
              // Speed Pill
              InkWell(
                onTap: _cycleSpeed,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white24, width: 0.8),
                  ),
                  child: Text(
                    '${_playbackSpeed}x',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              if (widget.onDelete != null) ...[
                const SizedBox(width: 6),
                InkWell(
                  onTap: widget.onDelete,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),

          // Middle Row: Play/Pause button + Animated Waveform Bars
          Row(
            children: [
              // Play/Pause Button
              InkWell(
                onTap: _togglePlayPause,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: AppColors.onPrimary,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Animated Waveform Visualizer
              Expanded(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    final box = context.findRenderObject() as RenderBox?;
                    if (box != null) {
                      final localPos = details.localPosition.dx;
                      final totalW = box.size.width - 60;
                      if (totalW > 0) {
                        setState(() {
                          _playbackProgress = (localPos / totalW).clamp(0.0, 1.0);
                        });
                      }
                    }
                  },
                  child: SizedBox(
                    height: 28,
                    child: AnimatedBuilder(
                      animation: _waveAnimController,
                      builder: (context, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(samples.length, (index) {
                            final rawHeight = samples[index];
                            final barProgress = index / (samples.length - 1);
                            final isPassed = barProgress <= _playbackProgress;

                            // Dynamic ripple modulation if playing
                            double heightFactor = rawHeight;
                            if (_isPlaying) {
                              final waveOffset = (index % 3) * 0.2;
                              final animatedWave = (_waveAnimController.value + waveOffset) % 1.0;
                              heightFactor = (rawHeight * 0.6) + (animatedWave * 0.4);
                            }

                            final barHeight = (heightFactor * 24.0).clamp(4.0, 26.0);

                            return Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1.5),
                                height: barHeight,
                                decoration: BoxDecoration(
                                  color: isPassed
                                      ? AppColors.primary
                                      : (isLight
                                          ? AppColors.primary.withValues(alpha: 0.25)
                                          : Colors.white24),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Bottom Row: Elapsed Time & Total Duration
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatElapsed(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  widget.memo.formattedDuration,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
