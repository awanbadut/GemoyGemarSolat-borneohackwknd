import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/features/pets/screens/pet_detail_screen.dart';

// ═══════════════════════════════════════════
// PROFILE SCREEN
// ═══════════════════════════════════════════
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120), // Spasi untuk Bottom Nav
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                // ── TAMBAHAN: XP CARD ──
                _buildXpCard(),
                const SizedBox(height: 24),
                _buildLanguagesExplored(),
                const SizedBox(height: 28),
                _buildPetCollection(context),
                const SizedBox(height: 28),
                _buildAccountSettings(context),
              ],
            ),
          ),

          // ── CUSTOM BOTTOM NAVIGATION BAR ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 85,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFE6F5FE), // Light blue background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.home_filled, size: 30, color: Colors.black87),
                    const Icon(Icons.pets, size: 28, color: Colors.black87),
                    const Icon(Icons.book, size: 28, color: Colors.black87),
                    // Active Profile Button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBBE5FB), // Cyan pill background
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.person, color: Color(0xFF004D73), size: 24),
                          SizedBox(width: 8),
                          Text('Profile',
                              style: TextStyle(
                                  color: Color(0xFF004D73),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ──
  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        // Background Gradient & Wavy Curve
        ClipPath(
          clipper: _HeaderWaveClipper(),
          child: Container(
            height: 280, // Tinggi area gradien disesuaikan
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF42E0FF), Color(0xFFE8F6FB), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),

        // Content (Title & Avatar)
        SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title (rata kiri) ──
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Your Profile',
                      style: TextStyle(
                        color: Color(0xFF05354C),
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Track your learning progress and manage your account',
                      style: TextStyle(
                        color: Color(0xFF05354C),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ── Avatar (tengah) ──
              Center(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Lingkaran Latar Belakang Biru untuk Avatar
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF6B8AFF), // Warna biru ungu latar belakang avatar
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              AppAssets.defaultAvatar,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        // Edit button di sudut kanan bawah avatar
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: Color(0xFF05354C),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Jhon',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── XP CARD (BARU) ──
  Widget _buildXpCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFEDF9F8), // Latar belakang hijau cyan sangat muda
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFD8EFEA), width: 1.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ikon Piala (Trophy) dengan background lingkaran putih
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events,
                color: Color(0xFFF1B78B), // Warna peach/oranye pastel
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Teks XP dan Progress Bar
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '950 XP',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Custom Progress Bar (Hijau memudar)
                  Stack(
                    children: [
                      Container(
                        height: 8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white, // Track
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.7, // Asumsi progress sekitar 70%
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF218C7E), Color(0xFF5CE1C6)], // Gradasi hijau tua ke hijau muda
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── LANGUAGES EXPLORED ──
  Widget _buildLanguagesExplored() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Languages Explored',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _StatCard(
                  icon: Icons.book_outlined,
                  iconColor: Color(0xFFF89B29),
                  label: 'Region',
                  value: '10',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.star_border_rounded,
                  iconColor: Color(0xFFF89B29),
                  label: 'Master',
                  value: '5',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.assignment_outlined,
                  iconColor: Color(0xFFF89B29),
                  label: 'Words',
                  value: '2354',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── PET COLLECTION ──
  Widget _buildPetCollection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pet Collection',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _PetCard(
                  name: 'Kaba The Buffalo',
                  level: 'Lvl. 12',
                  progress: 0.75,
                  petAsset: AppAssets.petAdult, // Sesuaikan ke asset kerbau besar
                  bgGlowColor: const Color(0xFFFFF6ED),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _PetCard(
                  name: 'Oru The Borneo',
                  level: 'Lvl. 12',
                  progress: 0.65,
                  petAsset: AppAssets.petTeen, // Sesuaikan ke asset orang utan
                  bgGlowColor: const Color(0xFFE8F6E9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── ACCOUNT & SETTINGS ──
  Widget _buildAccountSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account & Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Tile Akun
          _SettingsTile(
            title: 'Account',
            icon: Icons.person_rounded,
            iconBgColor: const Color(0xFFD6EEF8),
            iconColor: const Color(0xFF5C6BC0),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// STAT CARD (Languages Explored)
// ═══════════════════════════════════════════
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// PET CARD (Disesuaikan dari desain baru)
// ═══════════════════════════════════════════
class _PetCard extends StatelessWidget {
  final String name;
  final String level;
  final double progress;
  final String petAsset;
  final Color bgGlowColor;

  const _PetCard({
    required this.name,
    required this.level,
    required this.progress,
    required this.petAsset,
    required this.bgGlowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Lingkaran Pet dengan Badge Level ──
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                // Gambar membulat
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgGlowColor,
                    image: DecorationImage(
                      image: AssetImage(petAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Badge Level
                Positioned(
                  bottom: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD8F2FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Text(
                      level,
                      style: const TextStyle(
                        color: Color(0xFF1EA3B8),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Pet name ──
          Text(
            name,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 12),

          // ── Progress ──
          const Text(
            'Progress',
            style: TextStyle(
              color: Color(0xFF05354C),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),

          // Custom Progress Bar Oranye
          Stack(
            children: [
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9), // Track abu muda
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF89B29), // Orange Solid
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// SETTINGS TILE
// ═══════════════════════════════════════════
class _SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.title,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FB), // Warna abu-abu sangat muda
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: Color(0xFF9E9E9E), size: 24),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// CLIPPER: HEADER WAVE
// ═══════════════════════════════════════════
class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    // Gelombang
    path.quadraticBezierTo(size.width * 0.25, size.height + 20,
        size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 60, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}