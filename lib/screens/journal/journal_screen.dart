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
    if (_selectedMoodFilter == 'Pinned') {
      return allEntries.where((e) => e.isPinned).toList();
    }
    if (_selectedMoodFilter == 'All') {
      return allEntries;
    }
    return allEntries
        .where((e) => e.mood.label == _selectedMoodFilter)
        .toList();
  }

  void _handlePinToggle(JournalEntry entry) {
    final wasPinned = entry.isPinned;
    final success = JournalService.instance.togglePin(entry.id);

    if (!success && !wasPinned) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.info_outline_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pin limit reached! You can pin up to 5 reflections. Unpin an entry to pin another.',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFE07A5F),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wasPinned ? 'Unpinned from top' : 'Pinned to top (max 5) 📌',
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _confirmDeleteEntry(JournalEntry entry) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: Colors.white12),
        ),
        title: Row(
          children: const [
            Icon(
              Icons.delete_forever_rounded,
              color: Color(0xFFE05A47),
              size: 24,
            ),
            SizedBox(width: 10),
            Text(
              'Delete Reflection?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${entry.title}"? This reflection and all attached photos and memos will be removed.',
          style: TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: 13,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.onSurfaceVariant),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              final removed = JournalService.instance.removeEntry(entry.id);
              if (removed != null) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Deleted "${entry.title}"'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: AppColors.primary,
                      onPressed: () {
                        JournalService.instance.restoreEntry(removed);
                      },
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    duration: const Duration(seconds: 4),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE05A47),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: JournalService.instance,
      builder: (context, _) {
        final allEntries = JournalService.instance.entries;
        final filteredEntries = _getFilteredEntries(allEntries);
        final pinnedCount = JournalService.instance.pinnedCount;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 20,
            title: Row(
              children: [
                Text(
                  'Journal',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                if (pinnedCount > 0) ...[
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.push_pin_rounded, size: 12, color: AppColors.primary),
                        const SizedBox(width: 3),
                        Text(
                          '$pinnedCount/5',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
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
                      if (pinnedCount > 0) ...[
                        const SizedBox(width: 8),
                        _buildFilterChip('Pinned', displayLabel: 'Pinned 📌 ($pinnedCount)'),
                      ],
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
                                _selectedMoodFilter == 'Pinned'
                                    ? 'No pinned reflections'
                                    : 'No entries for this mood',
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

  Widget _buildFilterChip(String filterValue, {String? displayLabel}) {
    final isSelected = _selectedMoodFilter == filterValue;
    return ChoiceChip(
      label: Text(displayLabel ?? filterValue),
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
          _selectedMoodFilter = filterValue;
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
          color: entry.isPinned
              ? AppColors.primary.withValues(alpha: 0.35)
              : Colors.white10,
          width: entry.isPinned ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mood, Pinned status & Header Controls Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Mood and optional PINNED badge
              Row(
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
                  if (entry.isPinned) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.35),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.push_pin_rounded,
                            size: 11,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            'PINNED',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),

              // Date, quick pin button, and 3-dots menu
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
                  const SizedBox(width: 4),

                  // Quick Pin/Unpin icon
                  IconButton(
                    icon: Icon(
                      entry.isPinned ? Icons.push_pin_rounded : Icons.push_pin_outlined,
                      size: 18,
                      color: entry.isPinned
                          ? AppColors.primary
                          : AppColors.textMuted,
                    ),
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    padding: EdgeInsets.zero,
                    tooltip: entry.isPinned ? 'Unpin reflection' : 'Pin to top (max 5)',
                    onPressed: () => _handlePinToggle(entry),
                  ),

                  // 3-dots Menu for options including Delete
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert_rounded,
                      size: 18,
                      color: AppColors.textMuted,
                    ),
                    color: AppColors.surfaceContainerLowest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.white12),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    onSelected: (value) {
                      if (value == 'pin') {
                        _handlePinToggle(entry);
                      } else if (value == 'delete') {
                        _confirmDeleteEntry(entry);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'pin',
                        child: Row(
                          children: [
                            Icon(
                              entry.isPinned
                                  ? Icons.push_pin_outlined
                                  : Icons.push_pin_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              entry.isPinned ? 'Unpin Reflection' : 'Pin to Top (5 max)',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: const [
                            Icon(
                              Icons.delete_outline_rounded,
                              size: 18,
                              color: Color(0xFFE05A47),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Delete Reflection',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFFE05A47),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
