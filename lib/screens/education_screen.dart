import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/user_goal_session.dart';
import 'education_goals_screen.dart';

class EducationScreen extends StatefulWidget {
  final UserGoalSession session;

  const EducationScreen({
    super.key,
    required this.session,
  });

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  String _selectedFrequency = 'Weekly';
  String _selectedFocus = 'Personal Growth';
  String? _uploadedRoutineFileName;
  String? _uploadedRoutineFileType; // 'PDF' or 'IMAGE'
  String? _uploadedRoutineFileSize;
  String? _uploadError;

  final List<String> frequencies = ['Daily', 'Weekly', 'Monthly'];
  final List<String> focusAreas = [
    'Personal Growth',
    'University Degree',
    'Certification / Exam Prep'
  ];

  @override
  void initState() {
    super.initState();
    _selectedFrequency = widget.session.studyFrequency ?? 'Weekly';
    _selectedFocus = widget.session.educationFocus ?? 'Personal Growth';
    if (widget.session.studyMaterialName != null &&
        widget.session.studyMaterialName!.isNotEmpty) {
      _uploadedRoutineFileName = widget.session.studyMaterialName;
      _uploadedRoutineFileType =
          _uploadedRoutineFileName!.toLowerCase().endsWith('.pdf')
              ? 'PDF'
              : 'IMAGE';
      _uploadedRoutineFileSize = '1.8 MB';
    }
  }

  void _selectRoutineFile({required String type, String? customName}) {
    setState(() {
      _uploadError = null;
      if (type == 'PDF') {
        _uploadedRoutineFileName = customName ?? 'Academic_Class_Routine_2026.pdf';
        _uploadedRoutineFileType = 'PDF';
        _uploadedRoutineFileSize = '2.4 MB';
      } else {
        _uploadedRoutineFileName = customName ?? 'Weekly_Study_Schedule.png';
        _uploadedRoutineFileType = 'IMAGE';
        _uploadedRoutineFileSize = '1.6 MB';
      }
    });
  }

  void _showUploadPickerModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (modalContext) {
        final customNameController = TextEditingController();
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upload Routine File',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                    onPressed: () => Navigator.pop(modalContext),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Choose a format to upload your class routine or timetable:',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // PDF Option
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(modalContext);
                        _selectRoutineFile(type: 'PDF');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Routine PDF uploaded successfully!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.redAccent.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.picture_as_pdf_rounded,
                              size: 40,
                              color: Colors.redAccent,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'PDF Document',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '.pdf format',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Image Option
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(modalContext);
                        _selectRoutineFile(type: 'IMAGE');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Routine Image uploaded successfully!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4A373).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFD4A373).withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.image_rounded,
                              size: 40,
                              color: Color(0xFFD4A373),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Image File',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '.png, .jpg, .jpeg',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _handleContinue() {
    widget.session.studyFrequency = _selectedFrequency;
    widget.session.educationFocus = _selectedFocus;
    widget.session.studyMaterialName = _uploadedRoutineFileName;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EducationGoalsScreen(session: widget.session),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4A373).withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'EDUCATION SETUP',
                      style: TextStyle(
                        color: Color(0xFFD4A373),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Education Preferences',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Submit your routine file (optional), study frequency, and focus path.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),

              // 1. Submit Routine (PDF or Image, Optional)
              Row(
                children: [
                  _buildSectionTitle('SUBMIT ROUTINE (PDF OR IMAGE)'),
                  const SizedBox(width: 8),
                  const Text(
                    '(Optional)',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              if (_uploadedRoutineFileName == null) ...[
                // Upload Dropzone
                InkWell(
                  onTap: _showUploadPickerModal,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFD4A373).withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A373).withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.cloud_upload_outlined,
                            color: Color(0xFFD4A373),
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Upload Class or Study Routine',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Only PDF (.pdf) or Image (.png, .jpg) files supported',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => _selectRoutineFile(type: 'PDF'),
                              icon: const Icon(Icons.picture_as_pdf_rounded, size: 18),
                              label: const Text('Upload PDF'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
                                foregroundColor: Colors.redAccent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Colors.redAccent),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              onPressed: () => _selectRoutineFile(type: 'IMAGE'),
                              icon: const Icon(Icons.image_rounded, size: 18),
                              label: const Text('Upload Image'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFFD4A373).withValues(alpha: 0.2),
                                foregroundColor: const Color(0xFFD4A373),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Color(0xFFD4A373)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (_uploadError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _uploadError!,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ] else ...[
                // Selected File Preview Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFD4A373),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: _uploadedRoutineFileType == 'PDF'
                              ? Colors.redAccent.withValues(alpha: 0.18)
                              : const Color(0xFFD4A373).withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _uploadedRoutineFileType == 'PDF'
                              ? Icons.picture_as_pdf_rounded
                              : Icons.image_rounded,
                          color: _uploadedRoutineFileType == 'PDF'
                              ? Colors.redAccent
                              : const Color(0xFFD4A373),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _uploadedRoutineFileName!,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xFF81B29A),
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${_uploadedRoutineFileType ?? "FILE"} • ${_uploadedRoutineFileSize ?? "2.1 MB"} • Ready',
                                  style: const TextStyle(
                                    color: Color(0xFF81B29A),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Change File',
                        icon: const Icon(
                          Icons.swap_horiz_rounded,
                          color: Color(0xFFD4A373),
                        ),
                        onPressed: _showUploadPickerModal,
                      ),
                      IconButton(
                        tooltip: 'Remove',
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            _uploadedRoutineFileName = null;
                            _uploadedRoutineFileType = null;
                            _uploadedRoutineFileSize = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // 2. Study Frequency (Daily, Weekly, Monthly)
              _buildSectionTitle('STUDY FREQUENCY'),
              const SizedBox(height: 10),
              Row(
                children: frequencies.map((freq) {
                  final isSelected = _selectedFrequency == freq;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedFrequency = freq;
                          });
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.cardBgSelected
                                : AppColors.cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFD4A373)
                                  : Colors.white12,
                              width: isSelected ? 2.0 : 1.0,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            freq,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // 3. Focus Area
              _buildSectionTitle('FOCUS AREA'),
              const SizedBox(height: 10),
              Column(
                children: focusAreas.map((focus) {
                  final isSelected = _selectedFocus == focus;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedFocus = focus;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.cardBgSelected
                              : AppColors.cardBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFD4A373)
                                : Colors.white12,
                            width: isSelected ? 2.0 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline_rounded,
                              color: isSelected
                                  ? const Color(0xFFD4A373)
                                  : AppColors.textMuted,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                focus,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.textPrimary
                                      : AppColors.textSecondary,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFFD4A373),
                                size: 22,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 32),

              // Continue Button
              ElevatedButton(
                onPressed: _handleContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4A373),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 3,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Set Study Goals  →',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFFD4A373),
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    );
  }
}
