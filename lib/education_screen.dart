import 'package:flutter/material.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  // Currently selected frequency option ('Weekly', 'Monthly', or 'Yearly')
  String _selectedFrequency = 'Weekly';

  @override
  Widget build(BuildContext context) {
    // Exact theme palette from design
    const backgroundColor = Color(0xFF14100E);
    const cardUnselectedColor = Color(0xFF221A16);
    const cardSelectedColor = Color(0xFF52332B);
    const textColor = Color(0xFFEBE0D8);
    const subtextColor = Color(0xFFA8988E);
    const sectionHeaderColor = Color(0xFFC89B8C);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textColor),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Title Section
              const Text(
                'Education',
                style: TextStyle(
                  color: textColor,
                  fontSize: 32,
                  fontFamily: 'serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Set up your education preferences',
                style: TextStyle(
                  color: subtextColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 28),

              // 2. Upload Study Material Section
              _buildSectionTitle('UPLOAD STUDY MATERIAL', sectionHeaderColor),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardUnselectedColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: subtextColor.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.cloud_upload_outlined,
                      color: sectionHeaderColor,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Upload image',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Upload notes, book pages, or resources',
                            style: TextStyle(
                              color: subtextColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cardSelectedColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        color: textColor,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 3. Study Frequency Section (Without circles)
              _buildSectionTitle('STUDY FREQUENCY', sectionHeaderColor),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: cardUnselectedColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildFrequencyTile(
                      title: 'Weekly',
                      subtitle: 'Study every week',
                      isSelected: _selectedFrequency == 'Weekly',
                      onTap: () => setState(() => _selectedFrequency = 'Weekly'),
                      showDivider: true,
                    ),
                    _buildFrequencyTile(
                      title: 'Monthly',
                      subtitle: 'Study every month',
                      isSelected: _selectedFrequency == 'Monthly',
                      onTap: () => setState(() => _selectedFrequency = 'Monthly'),
                      showDivider: true,
                    ),
                    _buildFrequencyTile(
                      title: 'Yearly',
                      subtitle: 'Study every year',
                      isSelected: _selectedFrequency == 'Yearly',
                      onTap: () => setState(() => _selectedFrequency = 'Yearly'),
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 4. Focus Area Section (Display Only)
              _buildSectionTitle('FOCUS AREA', sectionHeaderColor),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardSelectedColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      color: textColor,
                      size: 28,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Self',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'This is for your personal growth',
                            style: TextStyle(
                              color: subtextColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Display-only checkmark badge
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEBE0D8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: cardUnselectedColor,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // 5. Save & Continue Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cardSelectedColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Action when saving education settings
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Save & Continue',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: textColor, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for Section Headers
  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    );
  }

  // Helper widget for Frequency Options (No Circle)
  Widget _buildFrequencyTile({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required bool showDivider,
  }) {
    const textColor = Color(0xFFEBE0D8);
    const subtextColor = Color(0xFFA8988E);

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: textColor,
                  size: 22,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: subtextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            color: Color(0xFF2D231E),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}