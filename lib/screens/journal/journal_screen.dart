import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/journal_entry.dart';
import '../../services/journal_service.dart';
import '../../widgets/liquid_glass.dart';
import 'widgets/journal_entry_modal.dart';
import 'widgets/journal_photo_gallery.dart';
import 'widgets/voice_memo_player_widget.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  String _selectedMoodFilter = 'All';

  List<JournalEntry> _getFilteredEntries(List<JournalEntry> allEntries) {
    if (_selectedMoodFilter == 'All') {
      return allEntries;
    }
    return allEntries
        .where((e) => e.mood.label == _selectedMoodFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: JournalService.instance,
      builder: (context, _) {
        final allEntries = JournalService.instance.entries;
        final filteredEntries = _getFilteredEntries(allEntries);

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 20,
            title: Text(
              'Journal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            actions: [
              const ThemeToggleButton(),
              const SizedBox(width: 4),
              IconButton(
                icon: Icon(Icons.add_rounded, color: AppColors.primary),
                onPressed: () {
                  showJournalEntryModal(context);
                },
                tooltip: 'New Journal Entry',
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: LiquidBackground(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      _buildFilterChip('All'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Calm'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Reflective'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Grateful'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Energetic'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Anxious'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Entries List
                Expanded(
                  child: filteredEntries.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.auto_stories_outlined,
                                size: 48,
                                color: AppColors.outline,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No entries for this mood',
                                style: TextStyle(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          itemCount: filteredEntries.length,
                          itemBuilder: (context, index) {
                            final entry = filteredEntries[index];
                            return _buildJournalCard(entry);
                          },
                        ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedMoodFilter == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.primary.withValues(alpha: 0.25),
      backgroundColor: AppColors.surfaceContainerHigh,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 13,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primary : Colors.white12,
      ),
      onSelected: (_) {
        setState(() {
          _selectedMoodFilter = label;
        });
      },
    );
  }

  Widget _buildJournalCard(JournalEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white10,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mood & Date row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: entry.mood.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(entry.mood.emoji, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      entry.mood.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: entry.mood.color,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  if (entry.images.isNotEmpty) ...[
                    Icon(Icons.photo_outlined, size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      '${entry.images.length}',
                      style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (entry.voiceMemos.isNotEmpty) ...[
                    Icon(Icons.mic_none_rounded, size: 14, color: const Color(0xFFE05A47)),
                    const SizedBox(width: 4),
                    Text(
                      '${entry.voiceMemos.length}',
                      style: TextStyle(fontSize: 11, color: const Color(0xFFE05A47)),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    '${entry.date.month}/${entry.date.day}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            entry.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 6),

          // Content body
          Text(
            entry.content,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.onSurfaceVariant,
              height: 1.4,
            ),
          ),

          // Attached Pictures (if any)
          if (entry.images.isNotEmpty) ...[
            JournalPhotoGallery(images: entry.images),
          ],

          // Attached Voice Memos (if any)
          if (entry.voiceMemos.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...entry.voiceMemos.map((memo) => VoiceMemoPlayerWidget(memo: memo)),
          ],

          // Gratitude Items
          if (entry.gratitudeItems.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: entry.gratitudeItems.map((g) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '✨ $g',
                    style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
