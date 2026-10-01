import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../services/gemini_insight_service.dart';

void showGeminiKeyModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surfaceContainerLowest,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (modalCtx) => const GeminiKeyModal(),
  );
}

class GeminiKeyModal extends StatefulWidget {
  const GeminiKeyModal({super.key});

  @override
  State<GeminiKeyModal> createState() => _GeminiKeyModalState();
}

class _GeminiKeyModalState extends State<GeminiKeyModal> {
  late TextEditingController _controller;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: GeminiInsightService.instance.apiKey ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveKey() {
    final key = _controller.text.trim();
    if (key.isEmpty) {
      GeminiInsightService.instance.clearApiKey();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Switched to local offline analysis mode.')),
      );
    } else {
      GeminiInsightService.instance.setApiKey(key);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gemini API key saved! Ready for neural analysis ✨')),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final hasKey = GeminiInsightService.instance.hasApiKey;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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

            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gemini AI Studio Setup',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                      ),
                      Text(
                        'Free Neural Growth & Downfall Analyzer',
                        style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Info Card about Free Gemini Key
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle_outline_rounded,
                          size: 16, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text(
                        '100% Free Tier (1,500 Requests / Day)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '1. Go to Google AI Studio at aistudio.google.com\n'
                    '2. Sign in with any Google account\n'
                    '3. Click "Get API key" -> "Create API key"\n'
                    '4. Paste it below to unlock deep psychological insights.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Text Field for API Key
            Text(
              'GEMINI API KEY',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              obscureText: _obscure,
              style: TextStyle(color: AppColors.onSurface, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Paste AIzaSy... key here',
                hintStyle: TextStyle(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.surfaceContainerHigh,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.onSurfaceVariant,
                    size: 18,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Actions
            Row(
              children: [
                if (hasKey)
                  TextButton.icon(
                    onPressed: () {
                      _controller.clear();
                      _saveKey();
                    },
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: const Text('Clear Key', style: TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: TextStyle(color: AppColors.onSurfaceVariant)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveKey,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Save & Apply', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
