import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

/// Helper function to open the Journal Entry modal bottom sheet from anywhere in the app!
/// 
/// BEGINNER TIP:
/// By putting `showJournalEntryModal` here, any button (like the 'Begin Entry'
/// button on Home or the floating Stylus FAB) can call this single function!
void showJournalEntryModal(BuildContext context, {String? prompt}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => JournalEntryModal(
      initialPrompt: prompt ?? 'What is one small moment of stillness you can protect today?',
    ),
  );
}

/// JournalEntryModal represents the rich, calm reflection writing sheet.
/// 
/// LOCATION:
/// screens/journal/widgets/ - Dedicated journal entry pop-up component.
class JournalEntryModal extends StatefulWidget {
  final String initialPrompt;

  const JournalEntryModal({
    super.key,
    required this.initialPrompt,
  });

  @override
  State<JournalEntryModal> createState() => _JournalEntryModalState();
}

class _JournalEntryModalState extends State<JournalEntryModal> {
  final TextEditingController _textController = TextEditingController();
  
  // State variables for interactive features
  int _wordCount = 0;
  String _selectedMood = 'Grateful';
  bool _showPhotoAttachment = true;
  bool _isVoiceRecording = false;
  int _recordingSeconds = 14;
  Timer? _recordingTimer;
  bool _isSaving = false;

  // Available mood options matching Stitch popup
  final List<Map<String, String>> _moods = const [
    {'emoji': '🌿', 'name': 'Calm'},
    {'emoji': '✨', 'name': 'Grateful'},
    {'emoji': '☕', 'name': 'Focused'},
    {'emoji': '🌙', 'name': 'Restful'},
  ];

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateWordCount);
  }

  @override
  void dispose() {
    _textController.removeListener(_updateWordCount);
    _textController.dispose();
    _recordingTimer?.cancel();
    super.dispose();
  }

  void _updateWordCount() {
    final text = _textController.text.trim();
    final words = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    if (words != _wordCount) {
      setState(() {
        _wordCount = words;
      });
    }
  }

  void _toggleVoiceRecording() {
    setState(() {
      _isVoiceRecording = !_isVoiceRecording;
      if (_isVoiceRecording) {
        _recordingSeconds = 14;
        _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _recordingSeconds++;
          });
        });
      } else {
        _recordingTimer?.cancel();
      }
    });
  }

  void _saveEntry() {
    setState(() {
      _isSaving = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.surfaceContainerHigh,
            content: Text(
              'Reflection saved to your Journal.',
              style: GoogleFonts.plusJakartaSans(color: AppColors.primary),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  String _formatTimer(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    // Keyboard inset ensures writing area stays above the on-screen keyboard
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      padding: EdgeInsets.only(bottom: keyboardInset),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1513),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.7),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Grab / Drag Handle
          Center(
            child: Container(
              width: 42,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              decoration: BoxDecoration(
                color: AppColors.outlineVariant.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // 2. Modal Top Header (Close, Title, Word count, Save button)
          _buildHeader(),

          // 3. Scrollable Content Area (Prompt, Moods, Text Input, Attachments)
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Prompt Reminder Card
                  _buildPromptCard(),
                  const SizedBox(height: 14),

                  // Mood Pills Selector Row
                  _buildMoodSelectorRow(),
                  const SizedBox(height: 14),

                  // Freeform Writing Textarea
                  _buildWritingArea(),
                  const SizedBox(height: 14),

                  // Optional Photo Memory Attachment
                  if (_showPhotoAttachment) ...[
                    _buildPhotoAttachment(),
                    const SizedBox(height: 14),
                  ],

                  // Voice Recording Active Banner
                  if (_isVoiceRecording) ...[
                    _buildVoiceRecordingBanner(),
                    const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ),

          // 4. Modal Action Dock / Footer Toolbar
          _buildFooterToolbar(),
        ],
      ),
    );
  }

  /// Top Modal Header Row
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Close button & 'Reflection' badge
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, size: 20),
                color: AppColors.onSurfaceVariant,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'REFLECTION',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Word counter & Save Entry Button
          Row(
            children: [
              Text(
                '$_wordCount word${_wordCount == 1 ? '' : 's'}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: AppColors.outline,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _isSaving ? null : _saveEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 1,
                ),
                child: Text(
                  _isSaving ? 'Saved!' : 'Save Entry',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Today's Prompt Banner
  Widget _buildPromptCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                "TODAY'S PROMPT",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            widget.initialPrompt,
            style: GoogleFonts.literata(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.35,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  /// Mood selector horizontal chip row
  Widget _buildMoodSelectorRow() {
    return Row(
      children: [
        Text(
          'Mood: ',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: AppColors.outline,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: _moods.map((m) {
                final isSelected = m['name'] == _selectedMood;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedMood = m['name']!;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.secondaryContainer.withValues(alpha: 0.5)
                            : AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.5)
                              : AppColors.outlineVariant.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(m['emoji']!, style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          Text(
                            m['name']!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  /// Freeform Writing Textarea
  Widget _buildWritingArea() {
    return Container(
      constraints: const BoxConstraints(minHeight: 140),
      child: TextField(
        controller: _textController,
        autofocus: true,
        maxLines: null,
        minLines: 5,
        style: GoogleFonts.literata(
          fontSize: 16,
          height: 1.6,
          color: AppColors.onSurface,
        ),
        decoration: InputDecoration(
          hintText: 'Pour your thoughts freely... Let this moment belong entirely to you.',
          hintStyle: GoogleFonts.literata(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: AppColors.outline.withValues(alpha: 0.6),
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  /// Attached Photo Memory Card
  Widget _buildPhotoAttachment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.image,
                  size: 15,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Attached Memory',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: AppColors.outline,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _showPhotoAttachment = false;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.close, size: 13, color: AppColors.outline),
                  const SizedBox(width: 2),
                  Text(
                    'Remove',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: AppColors.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.surfaceContainerHigh,
                      AppColors.secondaryContainer.withValues(alpha: 0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCcz_Kwpxs_a3yA_du6DCpBKo5hDhsUls30X2Z2m_kC66HlzGEmB2_UM86u5wKBP2ILwk4jg0KY9gQsQ9lwGpAt8wB9PIddXTVE15wyaE0-RKHf7sTWX_m9eoW4kcqCiCUX248TrBh5fefYK4g0KrP8SEfCZrValT8z55cgJkRBlkWh9da8aPsLHAIZVQtDlLOOfoQRBbG7B9GyDDIq8Xei8qWtxxrQzhkCJFzLxGfgi2aJlVDBTZgm',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(
                      Icons.landscape_outlined,
                      size: 40,
                      color: AppColors.primary.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.7),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    'Quiet dawn shoreline • 06:45 AM',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Voice Memo Recording Banner
  Widget _buildVoiceRecordingBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recording Voice Memo...',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '${_formatTimer(_recordingSeconds)} • Waveform active',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Stop Recording button
          InkWell(
            onTap: _toggleVoiceRecording,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.stop,
                size: 18,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Modal Action Dock / Footer Toolbar
  Widget _buildFooterToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.9),
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Formatting button
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Formatting options'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.format_size, size: 20),
                color: AppColors.onSurfaceVariant,
              ),

              // Add / Toggle Voice Memo
              TextButton.icon(
                onPressed: _toggleVoiceRecording,
                style: TextButton.styleFrom(
                  foregroundColor: _isVoiceRecording ? AppColors.primary : AppColors.onSurfaceVariant,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                icon: const Icon(Icons.mic, size: 19),
                label: Text(
                  'Add Voice',
                  style: GoogleFonts.plusJakartaSans(fontSize: 12),
                ),
              ),

              // Add / Toggle Photo
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _showPhotoAttachment = !_showPhotoAttachment;
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: _showPhotoAttachment ? AppColors.primary : AppColors.onSurfaceVariant,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                icon: const Icon(Icons.add_photo_alternate, size: 19),
                label: Text(
                  'Add Picture',
                  style: GoogleFonts.plusJakartaSans(fontSize: 12),
                ),
              ),
            ],
          ),

          // Privacy lock icon
          const Padding(
            padding: EdgeInsets.only(right: 6),
            child: Icon(
              Icons.lock,
              size: 18,
              color: AppColors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
