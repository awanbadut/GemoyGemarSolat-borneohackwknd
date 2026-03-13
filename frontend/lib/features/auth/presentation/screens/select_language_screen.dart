import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingupet/core/constants/app_assets.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String? _selectedCode;

  final List<_LangData> _languages = const [
    _LangData(flag: '🇬🇧', name: 'English',          subtitle: 'English',    code: 'en'),
    _LangData(flag: '🇮🇩', name: 'Bahasa Indonesia',  subtitle: 'Indonesian', code: 'id'),
    _LangData(flag: '🇲🇾', name: 'Bahasa Melayu',     subtitle: 'Malay',      code: 'ms'),
    _LangData(flag: '🇵🇭', name: 'Filipino',          subtitle: 'Filipino',   code: 'fil'),
    _LangData(flag: '🇻🇳', name: 'Tiếng Việt',        subtitle: 'Vietnamese', code: 'vi'),
    _LangData(flag: '🇹🇭', name: 'ไทย',               subtitle: 'Thai',       code: 'th'),
    _LangData(flag: '🇰🇭', name: 'ខ្មែរ',              subtitle: 'Khmer',      code: 'km'),
    _LangData(flag: '🇲🇲', name: 'မြန်မာဘာသာ',        subtitle: 'Burmese',    code: 'my'),
    _LangData(flag: '🇱🇦', name: 'ພາສາລາວ',           subtitle: 'Lao',        code: 'lo'),
    _LangData(flag: '🇧🇳', name: 'Melayu Brunei',     subtitle: 'Brunei',     code: 'bn'),
  ];

  @override
  Widget build(BuildContext context) {
    final bool hasSelected = _selectedCode != null;

    return Scaffold(
      backgroundColor: const Color(0xFFD6EEF8),
      body: SafeArea(
        child: Stack(
          children: [

            // ── DEKORASI ──
            Positioned(
              right: 20, top: 60,
              child: Icon(Icons.star_border_rounded,
                  size: 26,
                  color: const Color(0xFF38D1F5).withOpacity(0.5)),
            ),
            Positioned(
              right: 16, top: 200,
              child: Text('あ',
                  style: TextStyle(
                      fontSize: 28,
                      color: const Color(0xFF38D1F5).withOpacity(0.35),
                      fontWeight: FontWeight.bold)),
            ),
            Positioned(
              left: 12, bottom: 80,
              child: Icon(Icons.language_rounded,
                  size: 32,
                  color: const Color(0xFF38D1F5).withOpacity(0.4)),
            ),
            Positioned(
              right: 20, bottom: 90,
              child: Text('Ω',
                  style: TextStyle(
                      fontSize: 26,
                      color: const Color(0xFF38D1F5).withOpacity(0.3))),
            ),

            Column(
              children: [

                // ── TOP BAR ──
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.go('/register'),
                        child: Container(
                          width: 38, height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: Color(0xFF1A1A2E)),
                        ),
                      ),
                      const Expanded(
                        child: Text('Your Country',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E))),
                      ),
                      const SizedBox(width: 38),
                    ],
                  ),
                ),

                // ── MASCOT KECIL ──
                Image.asset(
                  AppAssets.maskotWelcome,
                  height: 90,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 16),

                // ── JUDUL ──
                const Text(
                  'Where are you from?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A2E),
                      letterSpacing: -0.3),
                ),
                const SizedBox(height: 6),
                const Text(
                  'This helps us personalize your learning experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B8499)),
                ),

                const SizedBox(height: 20),

                // ── LIST BAHASA ──
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _languages.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final lang = _languages[index];
                      final isSelected = _selectedCode == lang.code;

                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCode = lang.code),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFF5A623)
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [

                              // Flag
                              Text(lang.flag,
                                  style: const TextStyle(fontSize: 32)),

                              const SizedBox(width: 14),

                              // Nama + subtitle
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(lang.name,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1A1A2E))),
                                    const SizedBox(height: 2),
                                    Text(lang.subtitle,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF6B8499))),
                                  ],
                                ),
                              ),

                              // Check icon kalau selected
                              if (isSelected)
                                const Icon(Icons.check_circle_rounded,
                                    color: Color(0xFFF5A623), size: 22),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ── BUTTON CONTINUE ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: hasSelected
                          ? () => context.go('/home')
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasSelected
                            ? const Color(0xFFF5A623)
                            : const Color(0xFFB0BEC5),
                        foregroundColor: Colors.white,
                        elevation: hasSelected ? 6 : 0,
                        shadowColor: const Color(0xFFF5A623).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('Continue',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LangData {
  final String flag;
  final String name;
  final String subtitle;
  final String code;
  const _LangData({
    required this.flag,
    required this.name,
    required this.subtitle,
    required this.code,
  });
}

