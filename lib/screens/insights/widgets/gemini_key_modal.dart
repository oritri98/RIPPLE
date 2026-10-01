import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _isTesting = false;
  String? _testResultMsg;
  bool? _testResultSuccess;

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

  void _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null && data!.text!.isNotEmpty) {
      final clean = GeminiInsightService.sanitizeKey(data.text!);
      setState(() {
        _controller.text = clean;
        _testResultMsg = null;
        _testResultSuccess = null;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pasted and cleaned key from clipboard!')),
      );
    }
  }

  void _testConnection() async {
    final key = _controller.text.trim();
    if (key.isEmpty) {
      setState(() {
        _testResultMsg = 'Please enter or paste your API key first.';
        _testResultSuccess = false;
      });
      return;
    }

    setState(() {
      _isTesting = true;
      _testResultMsg = null;
      _testResultSuccess = null;
    });

    final result = await GeminiInsightService.instance.testKeyConnection(key);

    if (mounted) {
      setState(() {
        _isTesting = false;
        _testResultSuccess = result['success'] as bool;
        _testResultMsg = result['message'] as String;
      });
    }
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
                        '100% Free Tier (1,500 Calls / Day)',
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
                    '1. Open aistudio.google.com in your browser\n'
                    '2. Sign in with Google -> Tap "Get API key"\n'
                    '3. Tap "Create API key" and copy the key (starts with "AIzaSy..." or "AQ...")\n'
                    '4. Tap "Paste from Clipboard" below.',
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

            // Text Field for API Key with Paste & Obscure Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'GEMINI API KEY',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                InkWell(
                  onTap: _pasteFromClipboard,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.paste_rounded, size: 14, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          'Paste from Clipboard',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              obscureText: _obscure,
              style: TextStyle(color: AppColors.onSurface, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Paste Gemini key (e.g. AQ... or AIzaSy...)',
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
              onChanged: (_) {
                if (_testResultMsg != null) {
                  setState(() {
                    _testResultMsg = null;
                    _testResultSuccess = null;
                  });
                }
              },
            ),

            // Test Result Banner (if tested)
            if (_testResultMsg != null) ...[
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (_testResultSuccess == true)
                      ? const Color(0xFF81B29A).withValues(alpha: 0.15)
                      : const Color(0xFFE07A5F).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: (_testResultSuccess == true)
                        ? const Color(0xFF81B29A)
                        : const Color(0xFFE07A5F),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      (_testResultSuccess == true)
                          ? Icons.check_circle_rounded
                          : Icons.error_outline_rounded,
                      size: 18,
                      color: (_testResultSuccess == true)
                          ? const Color(0xFF81B29A)
                          : const Color(0xFFE07A5F),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _testResultMsg!,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.onSurface,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 18),

            // Actions: Test Key & Save
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: _isTesting ? null : _testConnection,
                  icon: _isTesting
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.network_check_rounded, size: 16),
                  label: Text(_isTesting ? 'Testing...' : 'Test Key'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary.withValues(alpha: 0.4)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
                const Spacer(),
                if (hasKey)
                  TextButton(
                    onPressed: () {
                      _controller.clear();
                      _saveKey();
                    },
                    child: const Text('Clear', style: TextStyle(color: Colors.redAccent)),
                  ),
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
