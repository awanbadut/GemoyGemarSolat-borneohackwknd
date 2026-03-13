import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';

class VerificationStatusScreen extends StatelessWidget {
  final String dialectName;
  final String regionName;
  final String countryName;
  final String countryFlag;

  const VerificationStatusScreen({
    super.key,
    required this.dialectName,
    required this.regionName,
    required this.countryName,
    required this.countryFlag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            'Verification Status',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF05354C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // KONTEN
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // ── CARD 1: Info Bahasa ──
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: const Color(0xFFEAEAEA)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Avatar Pet
                            Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE6F5FE),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.question_mark_rounded,
                                  color: Color(0xFF1EA3B8),
                                  size: 32,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  // ✅ Pakai data dinamis dari form
                                  Text(
                                    dialectName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF05354C),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$countryFlag $regionName, $countryName',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF757575),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Status Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF6ED),
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF89B29),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Text(
                                          'Currently Under Review',
                                          style: TextStyle(
                                            color: Color(0xFFF89B29),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── CARD 2: Timeline ──
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: const Color(0xFFEAEAEA)),
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
                            const Text(
                              'Progres Pengajuan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                            const SizedBox(height: 24),
                            _buildTimelineStep(
                              icon: Icons.check,
                              iconColor: Colors.white,
                              iconBg: const Color(0xFF1EA36D),
                              title: 'Submission Received',
                              subtitle: '12 Okt 2023, 10:30',
                              titleColor: const Color(0xFF1A1A2E),
                              subtitleColor: const Color(0xFF757575),
                              isLast: false,
                              lineColor: const Color(0xFF1EA36D),
                            ),
                            _buildTimelineStep(
                              icon: Icons.edit_document,
                              iconColor: Colors.white,
                              iconBg: const Color(0xFF1976D2),
                              title: 'Cultural Expert Review',
                              subtitle: 'In progress',
                              titleColor: const Color(0xFF1976D2),
                              subtitleColor: const Color(0xFF757575),
                              isLast: false,
                              lineColor: const Color(0xFFE0E0E0),
                            ),
                            _buildTimelineStep(
                              icon: Icons.verified_outlined,
                              iconColor: const Color(0xFFBDBDBD),
                              iconBg: const Color(0xFFFAFAFA),
                              title: 'Final Verification',
                              subtitle: 'Waiting in queue',
                              titleColor: const Color(0xFF9E9E9E),
                              subtitleColor: const Color(0xFFBDBDBD),
                              isLast: true,
                              lineColor: Colors.transparent,
                              hasBorder: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── CARD 3: Info Box ──
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F8FF),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: const Color(0xFFE6F5FE)),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline_rounded,
                                color: Color(0xFF1976D2), size: 20),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Our cultural experts are currently reviewing the dialect you submitted to make sure the information is accurate. Thank you for helping preserve local languages!',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4A5568),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Color titleColor,
    required Color subtitleColor,
    required bool isLast,
    required Color lineColor,
    bool hasBorder = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                    border: hasBorder
                        ? Border.all(
                            color: const Color(0xFFE0E0E0), width: 1.5)
                        : null,
                  ),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: lineColor,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
