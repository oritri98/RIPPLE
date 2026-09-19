import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../models/journal_entry.dart';
import '../../../models/mood_item.dart';

void showJournalEntryModal(BuildContext context, {Function(JournalEntry)? onSave}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surfaceContainerLowest,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (modalContext) => JournalEntryModal(onSave: onSave),
  );
}

class JournalEntryModal extends StatefulWidget {
  final Function(JournalEntry)? onSave;

  const JournalEntryModal({super.key, this.onSave});

  @override
  State<JournalEntryModal> createState() => _JournalEntryModalState();
}

class _JournalEntryModalState extends State<JournalEntryModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _gratitudeController = TextEditingController();

  MoodItem _selectedMood = MoodItem.defaultMoods[0];
  final List<String> _gratitudeItems = [];

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
      date: DateTime.now(),
      mood: _selectedMood,
      tags: ['Mindfulness', _selectedMood.label],
      gratitudeItems: List.from(_gratitudeItems),
    );

    JournalEntry.sampleEntries.insert(0, newEntry);

    if (widget.onSave != null) {
      widget.onSave!(newEntry);
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Journal entry saved to your timeline! ✨'),
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
        height: MediaQuery.of(context).size.height * 0.85,
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

            // Top Row: Close & Save
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 15),
                  ),
                ),
                const Text(
                  'New Journal Entry',
                  style: TextStyle(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
                    const Text(
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
                    const SizedBox(height: 20),

                    // Title Field
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Entry Title (optional)...',
                        hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 20),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Body Field
                    TextField(
                      controller: _contentController,
                      maxLines: 8,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.onSurface,
                        height: 1.5,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Write down your thoughts, intentions, or what is on your mind today...',
                        hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 15),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Gratitude Section
                    const Text(
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
                            style: const TextStyle(color: AppColors.onSurface, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'e.g. A peaceful morning walk...',
                              hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                              filled: true,
                              fillColor: AppColors.surfaceContainerHigh,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                          icon: const Icon(Icons.add_circle_rounded, color: AppColors.primary),
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
                            label: Text(item, style: const TextStyle(color: AppColors.onSurface, fontSize: 12)),
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
