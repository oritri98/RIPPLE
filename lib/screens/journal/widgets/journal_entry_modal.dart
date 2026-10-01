import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../models/journal_entry.dart';
import '../../../models/mood_item.dart';
import '../../../models/voice_memo_item.dart';
import '../../../services/journal_service.dart';
import 'voice_memo_player_widget.dart';
import 'voice_memo_recorder_widget.dart';

void showJournalEntryModal(
  BuildContext context, {
  DateTime? initialDate,
  Function(JournalEntry)? onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surfaceContainerLowest,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (modalContext) => JournalEntryModal(
      initialDate: initialDate,
      onSave: onSave,
    ),
  );
}

class JournalEntryModal extends StatefulWidget {
  final DateTime? initialDate;
  final Function(JournalEntry)? onSave;

  const JournalEntryModal({
    super.key,
    this.initialDate,
    this.onSave,
  });

  @override
  State<JournalEntryModal> createState() => _JournalEntryModalState();
}

class _JournalEntryModalState extends State<JournalEntryModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _gratitudeController = TextEditingController();

  late DateTime _entryDate;
  MoodItem _selectedMood = MoodItem.defaultMoods[0];
  final List<String> _gratitudeItems = [];
  final List<String> _attachedImages = [];
  final List<VoiceMemoItem> _attachedMemos = [];
  bool _isRecording = false;

  static const List<Map<String, String>> _curatedPhotos = [
    {
      'title': 'Morning Coffee',
      'url': 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Mindful Desk',
      'url': 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Golden Sunset',
      'url': 'https://images.unsplash.com/photo-1495616811223-4d98c6e9c869?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Lush Nature',
      'url': 'https://images.unsplash.com/photo-1518495973542-4542c06a5843?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Active Energy',
      'url': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Quiet Headspace',
      'url': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&w=800&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();
    _entryDate = widget.initialDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _gratitudeController.dispose();
    super.dispose();
  }

  void _addGratitude() {
    final text = _gratitudeController.text.trim();
    if (text.isNotEmpty && !_gratitudeItems.contains(text)) {
      setState(() {
        _gratitudeItems.add(text);
        _gratitudeController.clear();
      });
    }
  }

  void _showAddPhotoSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainerLow,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attach Photo to Entry',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_link_rounded),
                      tooltip: 'Enter Custom Image URL',
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _promptCustomImageUrl();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Select from mindful presets or provide an image link:',
                  style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _curatedPhotos.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final item = _curatedPhotos[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _attachedImages.add(item['url']!);
                          });
                          Navigator.pop(sheetContext);
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                item['url']!,
                                width: 90,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Container(
                                  width: 90,
                                  height: 80,
                                  color: AppColors.surfaceContainerHigh,
                                  child: const Icon(Icons.photo),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['title']!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _promptCustomImageUrl();
                    },
                    icon: const Icon(Icons.link_rounded, size: 18),
                    label: const Text('Add Custom Image URL'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary.withValues(alpha: 0.5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _promptCustomImageUrl() {
    final urlController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Add Image Link',
            style: TextStyle(color: AppColors.onSurface, fontSize: 17),
          ),
          content: TextField(
            controller: urlController,
            style: TextStyle(color: AppColors.onSurface),
            decoration: InputDecoration(
              hintText: 'https://example.com/photo.jpg',
              hintStyle: TextStyle(color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.surfaceContainerHigh,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: Text('Cancel', style: TextStyle(color: AppColors.onSurfaceVariant)),
            ),
            ElevatedButton(
              onPressed: () {
                final url = urlController.text.trim();
                if (url.isNotEmpty) {
                  setState(() {
                    _attachedImages.add(url);
                  });
                }
                Navigator.pop(dialogCtx);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _pickEntryDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _entryDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _entryDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _entryDate.hour,
          _entryDate.minute,
        );
      });
    }
  }

  void _handleSave() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write a reflection before saving.')),
      );
      return;
    }

    final newEntry = JournalEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.isEmpty ? 'Daily Reflection' : title,
      content: content,
      date: _entryDate,
      mood: _selectedMood,
      tags: ['Mindfulness', _selectedMood.label],
      gratitudeItems: List.from(_gratitudeItems),
      images: List.from(_attachedImages),
      voiceMemos: List.from(_attachedMemos),
    );

    JournalService.instance.addEntry(newEntry);

    if (widget.onSave != null) {
      widget.onSave!(newEntry);
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Journal entry & memories saved to your timeline! ✨'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.90,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Top Row: Close, Date, & Save
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 15),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'New Journal Entry',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      InkWell(
                        onTap: _pickEntryDate,
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today_rounded, size: 11, color: AppColors.primary),
                            const SizedBox(width: 4),
                            Text(
                              '${_entryDate.month}/${_entryDate.day}/${_entryDate.year}',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Divider(color: Colors.white12, height: 24),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mood check-in
                    Text(
                      'HOW ARE YOU FEELING?',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: MoodItem.defaultMoods.map((mood) {
                          final isSelected = _selectedMood.label == mood.label;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              label: Text('${mood.emoji} ${mood.label}'),
                              selected: isSelected,
                              selectedColor: mood.color.withValues(alpha: 0.3),
                              backgroundColor: AppColors.surfaceContainerHigh,
                              labelStyle: TextStyle(
                                color: isSelected ? mood.color : AppColors.onSurfaceVariant,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                              side: BorderSide(
                                color: isSelected ? mood.color : Colors.white12,
                              ),
                              onSelected: (_) {
                                setState(() {
                                  _selectedMood = mood;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Title Field
                    TextField(
                      controller: _titleController,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Entry Title (optional)...',
                        hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 20),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Body Field
                    TextField(
                      controller: _contentController,
                      maxLines: 6,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.onSurface,
                        height: 1.5,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Write down your thoughts, intentions, or what is on your mind today...',
                        hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 15),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Media Action Bar: Add Photos & Voice Memos
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Add Photo Action
                          InkWell(
                            onTap: _showAddPhotoSheet,
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              child: Row(
                                children: [
                                  Icon(Icons.add_photo_alternate_rounded,
                                      size: 18, color: AppColors.primary),
                                  const SizedBox(width: 6),
                                  Text(
                                    _attachedImages.isEmpty
                                        ? 'Add Photo'
                                        : 'Photos (${_attachedImages.length})',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(width: 1, height: 20, color: Colors.white12),
                          // Voice Memo Action
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isRecording = true;
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              child: Row(
                                children: [
                                  Icon(Icons.mic_rounded,
                                      size: 18, color: const Color(0xFFE05A47)),
                                  const SizedBox(width: 6),
                                  Text(
                                    _attachedMemos.isEmpty
                                        ? 'Voice Memo'
                                        : 'Memos (${_attachedMemos.length})',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Active Voice Recorder Panel
                    if (_isRecording)
                      VoiceMemoRecorderWidget(
                        onRecorded: (memo) {
                          setState(() {
                            _attachedMemos.add(memo);
                            _isRecording = false;
                          });
                        },
                        onCancel: () {
                          setState(() {
                            _isRecording = false;
                          });
                        },
                      ),

                    // Attached Voice Memos List
                    if (_attachedMemos.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        'ATTACHED VOICE MEMOS',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ..._attachedMemos.map((memo) {
                        return VoiceMemoPlayerWidget(
                          memo: memo,
                          onDelete: () {
                            setState(() {
                              _attachedMemos.remove(memo);
                            });
                          },
                        );
                      }),
                    ],

                    // Attached Pictures Preview Strip
                    if (_attachedImages.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        'ATTACHED PICTURES',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 90,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _attachedImages.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final imgUrl = _attachedImages[index];
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    imgUrl,
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => Container(
                                      width: 90,
                                      height: 90,
                                      color: AppColors.surfaceContainerHigh,
                                      child: const Icon(Icons.photo_outlined),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _attachedImages.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.7),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.close_rounded,
                                          size: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 20),

                    // Gratitude Section
                    Text(
                      'GRATITUDE CHECK-IN (OPTIONAL)',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _gratitudeController,
                            style: TextStyle(color: AppColors.onSurface, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'e.g. A peaceful morning walk...',
                              hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
                              filled: true,
                              fillColor: AppColors.surfaceContainerHigh,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onSubmitted: (_) => _addGratitude(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: _addGratitude,
                          icon: Icon(Icons.add_circle_rounded, color: AppColors.primary),
                        ),
                      ],
                    ),
                    if (_gratitudeItems.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: _gratitudeItems.map((item) {
                          return Chip(
                            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                            label: Text(item,
                                style: TextStyle(color: AppColors.onSurface, fontSize: 12)),
                            onDeleted: () {
                              setState(() {
                                _gratitudeItems.remove(item);
                              });
                            },
                            deleteIconColor: AppColors.onSurfaceVariant,
                            side: BorderSide.none,
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
