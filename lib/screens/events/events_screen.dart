import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/journal_entry.dart';
import '../../models/mood_item.dart';
import '../../models/voice_memo_item.dart';
import '../../models/user_goal_session.dart';
import '../../services/journal_service.dart';
import '../../widgets/liquid_glass.dart';
import '../journal/widgets/journal_entry_modal.dart';
import '../journal/widgets/journal_photo_gallery.dart';
import '../journal/widgets/voice_memo_player_widget.dart';

class EventsScreen extends StatefulWidget {
  final UserGoalSession? session;

  const EventsScreen({
    super.key,
    this.session,
  });

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;
  String _activeFilter = 'All';

  static const List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedMonth = DateTime(now.year, now.month, 1);
    _selectedDate = DateTime(now.year, now.month, now.day);
  }

  void _previousMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
    });
  }

  void _goToToday() {
    final now = DateTime.now();
    setState(() {
      _focusedMonth = DateTime(now.year, now.month, 1);
      _selectedDate = DateTime(now.year, now.month, now.day);
    });
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int _daysInMonth(int year, int month) {
    final firstDayThisMonth = DateTime(year, month, 1);
    final firstDayNextMonth = DateTime(year, month + 1, 1);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: JournalService.instance,
      builder: (context, _) {
        final journalService = JournalService.instance;
        final selectedDayEntries = journalService.getEntriesForDate(_selectedDate);
        final selectedDayImages = journalService.getImagesForDate(_selectedDate);
        final selectedDayVoiceMemos = journalService.getVoiceMemosForDate(_selectedDate);
        final selectedDayMood = journalService.getDominantMoodForDate(_selectedDate);

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: _buildAppBar(context),
          body: LiquidBackground(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Month Navigation Header
                  _buildMonthHeader(),
                  const SizedBox(height: 12),

                  // 2. Filter Pills (All, Photos, Voice, Moods)
                  _buildFilterBar(),
                  const SizedBox(height: 14),

                  // 3. Calendar Grid Card
                  _buildCalendarCard(journalService),
                  const SizedBox(height: 16),

                  // 4. Month Memory Statistics Pill Bar
                  _buildMonthStatsBar(journalService),
                  const SizedBox(height: 18),

                  // 5. Selected Date Highlights & Memories
                  _buildSelectedDateDetails(
                    selectedDayEntries: selectedDayEntries,
                    images: selectedDayImages,
                    voiceMemos: selectedDayVoiceMemos,
                    mood: selectedDayMood,
                  ),

                  // Bottom padding for navigation bar
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.calendar_month_rounded,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Events',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  'Calendar & Memory Timeline',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        const ThemeToggleButton(),
        const SizedBox(width: 4),
        IconButton(
          onPressed: () {
            showJournalEntryModal(
              context,
              initialDate: _selectedDate,
              onSave: (_) => setState(() {}),
            );
          },
          icon: Icon(Icons.add_rounded, color: AppColors.primary),
          tooltip: 'Add Entry for Selected Date',
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildMonthHeader() {
    final monthName = _monthNames[_focusedMonth.month - 1];
    final year = _focusedMonth.year;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    '$monthName $year',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: _goToToday,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: _previousMonth,
                icon: const Icon(Icons.chevron_left_rounded, size: 24),
                color: AppColors.onSurfaceVariant,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: _nextMonth,
                icon: const Icon(Icons.chevron_right_rounded, size: 24),
                color: AppColors.onSurfaceVariant,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    final filters = ['All', '📷 Photos', '🎙️ Voice', 'Calm', 'Reflective', 'Grateful', 'Energetic'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((f) {
          final isSelected = _activeFilter == f;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(f),
              selected: isSelected,
              selectedColor: AppColors.primary.withValues(alpha: 0.25),
              backgroundColor: AppColors.surfaceContainerHigh,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              side: BorderSide(
                color: isSelected ? AppColors.primary : Colors.white12,
              ),
              onSelected: (_) {
                setState(() {
                  _activeFilter = f;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendarCard(JournalService journalService) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          // Days of Week Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _weekDays.map((d) {
              final isWeekend = d == 'Sat' || d == 'Sun';
              return Expanded(
                child: Center(
                  child: Text(
                    d,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isWeekend
                          ? AppColors.textMuted
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 10),

          // Days Grid
          _buildDaysGrid(journalService),
        ],
      ),
    );
  }

  Widget _buildDaysGrid(JournalService journalService) {
    final year = _focusedMonth.year;
    final month = _focusedMonth.month;
    final daysInCurrent = _daysInMonth(year, month);

    // 1 = Monday, 7 = Sunday
    final firstDayWeekday = DateTime(year, month, 1).weekday;
    final leadingBlanks = firstDayWeekday - 1;

    final daysInPrev = month == 1
        ? _daysInMonth(year - 1, 12)
        : _daysInMonth(year, month - 1);

    final totalCells = (leadingBlanks + daysInCurrent > 35) ? 42 : 35;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.65,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        int dayNum;
        bool isCurrentMonth = true;
        DateTime cellDate;

        if (index < leadingBlanks) {
          // Days from previous month
          dayNum = daysInPrev - (leadingBlanks - index - 1);
          isCurrentMonth = false;
          cellDate = DateTime(month == 1 ? year - 1 : year, month == 1 ? 12 : month - 1, dayNum);
        } else if (index >= leadingBlanks + daysInCurrent) {
          // Days from next month
          dayNum = index - (leadingBlanks + daysInCurrent) + 1;
          isCurrentMonth = false;
          cellDate = DateTime(month == 12 ? year + 1 : year, month == 12 ? 1 : month + 1, dayNum);
        } else {
          // Current month
          dayNum = index - leadingBlanks + 1;
          isCurrentMonth = true;
          cellDate = DateTime(year, month, dayNum);
        }

        final entriesForDay = journalService.getEntriesForDate(cellDate);
        final imagesForDay = journalService.getImagesForDate(cellDate);
        final voiceMemosForDay = journalService.getVoiceMemosForDate(cellDate);
        final moodForDay = journalService.getDominantMoodForDate(cellDate);
        final isSelected = _isSameDay(cellDate, _selectedDate);
        final isToday = _isSameDay(cellDate, DateTime.now());

        // Check active filter
        bool matchesFilter = true;
        if (_activeFilter == '📷 Photos') {
          matchesFilter = imagesForDay.isNotEmpty;
        } else if (_activeFilter == '🎙️ Voice') {
          matchesFilter = voiceMemosForDay.isNotEmpty;
        } else if (_activeFilter != 'All') {
          matchesFilter = moodForDay != null && moodForDay.label == _activeFilter;
        }

        return _buildDateCell(
          dayNum: dayNum,
          date: cellDate,
          isCurrentMonth: isCurrentMonth,
          isSelected: isSelected,
          isToday: isToday,
          entries: entriesForDay,
          images: imagesForDay,
          voiceMemos: voiceMemosForDay,
          mood: moodForDay,
          matchesFilter: matchesFilter,
        );
      },
    );
  }

  Widget _buildDateCell({
    required int dayNum,
    required DateTime date,
    required bool isCurrentMonth,
    required bool isSelected,
    required bool isToday,
    required List<JournalEntry> entries,
    required List<String> images,
    required List<VoiceMemoItem> voiceMemos,
    required MoodItem? mood,
    required bool matchesFilter,
  }) {
    final hasImage = images.isNotEmpty;
    final hasVoice = voiceMemos.isNotEmpty;
    final hasMood = mood != null;

    final cellOpacity = isCurrentMonth
        ? (matchesFilter ? 1.0 : 0.25)
        : (matchesFilter ? 0.35 : 0.15);

    return Opacity(
      opacity: cellOpacity,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedDate = date;
            if (!isCurrentMonth) {
              _focusedMonth = DateTime(date.year, date.month, 1);
            }
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.22)
                : (isToday
                    ? AppColors.primary.withValues(alpha: 0.10)
                    : AppColors.surfaceContainerHigh),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : (isToday
                      ? AppColors.primary.withValues(alpha: 0.5)
                      : (hasMood && isCurrentMonth
                          ? mood.color.withValues(alpha: 0.4)
                          : Colors.white10)),
              width: isSelected ? 2.0 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Stack(
              children: [
                // 1. Background image preview inside the date cell (if available!)
                if (hasImage && isCurrentMonth)
                  Positioned.fill(
                    child: Image.network(
                      images.first,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
                    ),
                  ),

                // Gradient scrim so date & indicators are razor-sharp
                if (hasImage && isCurrentMonth)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.70),
                            Colors.black.withValues(alpha: 0.25),
                            Colors.black.withValues(alpha: 0.75),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                // 2. Cell content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Top Row: Day number & Voice icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 1),
                              decoration: isToday
                                  ? BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(5),
                                    )
                                  : null,
                              child: Text(
                                '$dayNum',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: (isToday || isSelected)
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  color: isToday
                                      ? AppColors.onPrimary
                                      : (hasImage
                                          ? Colors.white
                                          : (isCurrentMonth
                                              ? AppColors.onSurface
                                              : AppColors.textMuted)),
                                ),
                              ),
                            ),
                          ),
                          if (hasVoice)
                            Container(
                              padding: const EdgeInsets.all(1.5),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE05A47),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.mic_rounded,
                                size: 7.5,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),

                      // Center/Bottom: Mood Emoji or Photo Indicator
                      if (hasMood)
                        Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            mood.emoji,
                            style: const TextStyle(fontSize: 10),
                          ),
                        )
                      else if (hasImage)
                        const Icon(
                          Icons.photo_camera_rounded,
                          size: 10,
                          color: Colors.white70,
                        )
                      else
                        const SizedBox(height: 10),

                      // Bottom Indicator dots (e.g. entry count)
                      if (entries.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            entries.length.clamp(1, 3),
                            (i) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: hasMood ? mood.color : AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        )
                      else
                        const SizedBox(height: 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMonthStatsBar(JournalService journalService) {
    int totalPhotos = 0;
    int totalVoice = 0;
    int totalEntries = 0;
    final moodCounts = <String, int>{};

    for (final entry in journalService.entries) {
      if (entry.date.year == _focusedMonth.year && entry.date.month == _focusedMonth.month) {
        totalEntries++;
        totalPhotos += entry.images.length;
        totalVoice += entry.voiceMemos.length;
        moodCounts[entry.mood.label] = (moodCounts[entry.mood.label] ?? 0) + 1;
      }
    }

    String dominantMood = 'None';
    if (moodCounts.isNotEmpty) {
      dominantMood = moodCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Expanded(child: _buildStatItem('Entries', '$totalEntries', Icons.auto_stories_outlined)),
          Container(width: 1, height: 22, color: Colors.white12),
          Expanded(child: _buildStatItem('Photos', '$totalPhotos', Icons.photo_camera_outlined)),
          Container(width: 1, height: 22, color: Colors.white12),
          Expanded(child: _buildStatItem('Voice Memos', '$totalVoice', Icons.mic_none_rounded)),
          Container(width: 1, height: 22, color: Colors.white12),
          Expanded(child: _buildStatItem('Mood', dominantMood, Icons.sentiment_satisfied_rounded)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 12, color: AppColors.primary),
            const SizedBox(width: 3),
            Flexible(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 10, color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildSelectedDateDetails({
    required List<JournalEntry> selectedDayEntries,
    required List<String> images,
    required List<VoiceMemoItem> voiceMemos,
    required MoodItem? mood,
  }) {
    final monthName = _monthNames[_selectedDate.month - 1];
    final dayOfWeek = _weekDays[_selectedDate.weekday - 1];
    final formattedDate = '$dayOfWeek, $monthName ${_selectedDate.day}, ${_selectedDate.year}';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Date & Add Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MEMORIES & HIGHLIGHTS',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      formattedDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {
                  showJournalEntryModal(
                    context,
                    initialDate: _selectedDate,
                    onSave: (_) => setState(() {}),
                  );
                },
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('Add Entry', style: TextStyle(fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary.withValues(alpha: 0.5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Mood of the Day Card
          if (mood != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: mood.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: mood.color.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Text(mood.emoji, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mood on this date: ${mood.label}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: mood.color,
                          ),
                        ),
                        Text(
                          'Recorded from your reflections on $monthName ${_selectedDate.day}',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Images Section for selected date
          if (images.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.photo_camera_rounded, size: 16, color: AppColors.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Pictures Added (${images.length})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            JournalPhotoGallery(images: images, compact: true),
            const SizedBox(height: 16),
          ],

          // Voice Memos Section for selected date
          if (voiceMemos.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.mic_rounded, size: 16, color: const Color(0xFFE05A47)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Voice Memos (${voiceMemos.length})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...voiceMemos.map((memo) => VoiceMemoPlayerWidget(memo: memo, compact: true)),
            const SizedBox(height: 16),
          ],

          // Journal Reflections List for selected date
          if (selectedDayEntries.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.auto_stories_rounded, size: 16, color: AppColors.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Journal Reflections (${selectedDayEntries.length})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...selectedDayEntries.map((entry) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            entry.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${entry.date.hour.toString().padLeft(2, '0')}:${entry.date.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                    if (entry.gratitudeItems.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        children: entry.gratitudeItems.map((g) {
                          return Text(
                            '✨ $g',
                            style: TextStyle(fontSize: 10, color: AppColors.primary),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              );
            }),
          ] else ...[
            // Empty state for selected date
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_note_rounded,
                      size: 44,
                      color: AppColors.outline.withValues(alpha: 0.6),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No memories recorded for this day yet',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        showJournalEntryModal(
                          context,
                          initialDate: _selectedDate,
                          onSave: (_) => setState(() {}),
                        );
                      },
                      icon: const Icon(Icons.add_photo_alternate_outlined, size: 16),
                      label: const Text('Capture Memory, Photo or Voice'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
