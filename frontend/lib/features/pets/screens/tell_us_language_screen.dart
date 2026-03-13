import 'package:flutter/material.dart';
import 'package:lingupet/features/pets/screens/complete_add_language.dart';

class TellUsLanguageScreen extends StatefulWidget {
  final String countryName;
  final String countryFlag;

  const TellUsLanguageScreen({
    super.key,
    required this.countryName,
    required this.countryFlag,
  });

  @override
  State<TellUsLanguageScreen> createState() => _TellUsLanguageScreenState();
}

class _TellUsLanguageScreenState extends State<TellUsLanguageScreen> {
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _dialectController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // Cek apakah semua field terisi
  bool get _isFormFilled =>
      _regionController.text.trim().isNotEmpty &&
      _dialectController.text.trim().isNotEmpty &&
      _descController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    // Rebuild setiap kali input berubah untuk update state tombol
    _regionController.addListener(() => setState(() {}));
    _dialectController.addListener(() => setState(() {}));
    _descController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _regionController.dispose();
    _dialectController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          // ── MAIN SCROLLABLE CONTENT ──
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              children: [
                // HEADER WAVE
                ClipPath(
                  clipper: _HeaderWaveClipper(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 50, left: 24, right: 24, bottom: 40),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF42E0FF),
                          Color(0xFFF1F9FF),
                          Colors.white,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 0.6, 1.0],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Button & Title
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: Color(0xFF00334E), size: 22),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Text(
                                'Tell Us About this Language',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF05354C),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Help others learn by providing accurate details\nabout local speech patterns.',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF598EA7),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Country Chip dari AddLanguageScreen
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xFFD0F0FA)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(widget.countryFlag,
                                  style: const TextStyle(fontSize: 18)),
                              const SizedBox(width: 8),
                              Text(
                                widget.countryName,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF05354C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // FORM SECTIONS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Card 1: Select Region
                      _buildFormCard(
                        label: 'Select Region',
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFFEAEAEA)),
                          ),
                          child: TextField(
                            controller: _regionController,
                            decoration: const InputDecoration(
                              hintText: 'e.g. West Java',
                              hintStyle: TextStyle(
                                  color: Color(0xFFBDBDBD),
                                  fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF05354C)),
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Card 2: Dialect Name
                      _buildFormCard(
                        label: 'Dialect Name',
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFFEAEAEA)),
                          ),
                          child: TextField(
                            controller: _dialectController,
                            decoration: const InputDecoration(
                              hintText: 'e.g. Sunda Priangan',
                              hintStyle: TextStyle(
                                  color: Color(0xFFBDBDBD),
                                  fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Card 3: Description
                      _buildFormCard(
                        label: 'Description',
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFFEAEAEA)),
                          ),
                          child: TextField(
                            controller: _descController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText:
                                  'Describe the dialect, its speakers, and cultural significance...',
                              hintStyle: TextStyle(
                                  color: Color(0xFFBDBDBD),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── FLOATING SUBMIT BUTTON ──
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 56,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: _isFormFilled
                      ? [
                          BoxShadow(
                            color: const Color(0xFFF89B29)
                                .withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: ElevatedButton(
                  onPressed: _isFormFilled
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CompleteAddLanguageScreen(
                                dialectName: _dialectController.text.trim(),
                                regionName: _regionController.text.trim(),
                                countryName: widget.countryName,
                                countryFlag: widget.countryFlag,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormFilled
                        ? const Color(0xFFF89B29)
                        : const Color(0xFFBDBDBD),
                    disabledBackgroundColor: const Color(0xFFBDBDBD),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(
      {required String label, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAEAEA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF05354C),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width * 0.25, size.height + 10,
        size.width * 0.5, size.height - 15);
    path.quadraticBezierTo(size.width * 0.75, size.height - 40,
        size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
