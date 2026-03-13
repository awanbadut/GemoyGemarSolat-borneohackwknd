import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/features/pets/screens/verification_status_screen.dart';

class CompleteAddLanguageScreen extends StatelessWidget {
  final String dialectName;
  final String regionName;
  final String countryName;
  final String countryFlag;

  const CompleteAddLanguageScreen({
    super.key,
    required this.dialectName,
    required this.regionName,
    required this.countryName,
    required this.countryFlag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFD6EEF8),
            ],
            stops: [0.3, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // ── GELOMBANG CYAN DI ATAS ──
            ClipPath(
              clipper: _TopWaveClipper(),
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF42E0FF), Color(0xFFE8F6FB)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // ── ORNAMEN MELAYANG ──
            const Positioned(
              top: 130,
              left: 40,
              child: Icon(Icons.brightness_low_rounded,
                  color: Color(0xFFF5A623), size: 24),
            ),
            const Positioned(
              top: 250,
              left: 30,
              child: Icon(Icons.celebration_outlined,
                  color: Color(0xFF1976D2), size: 32),
            ),
            const Positioned(
              top: 160,
              right: 60,
              child: Icon(Icons.star_border_rounded,
                  color: Color(0xFFF5A623), size: 28),
            ),
            const Positioned(
              top: 240,
              right: 35,
              child: Icon(Icons.favorite_border_rounded,
                  color: Color(0xFF4CAF50), size: 32),
            ),

            // ── KONTEN UTAMA ──
            SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Gambar Maskot
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 280,
                          height: 280,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE6F5FE),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Image.asset(
                          AppAssets.tunjuk,
                          width: 250,
                          height: 250,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.pets_rounded,
                            size: 100,
                            color: Color(0xFFF89B29),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Judul
                  const Text(
                    'language Added',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFF89B29),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Deskripsi — pakai data dinamis dari form
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A5568),
                        ),
                        children: [
                          TextSpan(
                            text: '$dialectName ',
                            style: const TextStyle(
                                color: Color(0xFF1976D2)),
                          ),
                          const TextSpan(
                            text:
                                'has been added to\nyour collection.This language is currently being\nreviewed by cultural experts.',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // ── TOMBOL BAWAH ──
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        // Button 1: Verification Status
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VerificationStatusScreen(
                                    dialectName: dialectName,
                                    regionName: regionName,
                                    countryName: countryName,
                                    countryFlag: countryFlag,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF89B29),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Text(
                              'Verification Status',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Button 2: Back to Pets
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            // Pop sampai ke PetListPage
                            onPressed: () => Navigator.popUntil(
                                context, (route) => route.isFirst),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Text(
                              'Back to Pets',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF05354C),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(size.width * 0.25, size.height,
        size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(size.width * 0.75, size.height - 40,
        size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
