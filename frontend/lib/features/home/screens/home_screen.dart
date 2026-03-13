import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/features/learn/screens/learn_screen.dart';
import 'package:lingupet/features/pets/screens/build_vocabulary_page.dart';
import 'package:lingupet/features/pets/screens/pet_detail_screen.dart';
import 'package:lingupet/features/profile/screens/profile_screen.dart';

// ═══════════════════════════════════════════
// HOME SCREEN
// ═══════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNav = 0;

  List<Widget> get _screens => [
        _HomeTab(
          onPetSeeAll: () => setState(() => _currentNav = 1),
          onLearnSeeAll: () => setState(() => _currentNav = 2),
          onQuickFeed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BuildVocabularyPage()),
          ),
        ),
        const PetDetailScreen(),
        const LearnScreen(),
        const ProfileScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FBFD),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentNav,
            children: _screens,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomNav(
              current: _currentNav,
              onTap: (i) => setState(() => _currentNav = i),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// HOME TAB
// ═══════════════════════════════════════════
class _HomeTab extends StatelessWidget {
  final VoidCallback onPetSeeAll;
  final VoidCallback onLearnSeeAll;
  final VoidCallback onQuickFeed;

  const _HomeTab({
    required this.onPetSeeAll,
    required this.onLearnSeeAll,
    required this.onQuickFeed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header Wave ──
          Stack(
            children: [
              ClipPath(
                clipper: _HeaderWaveClipper(),
                child: Container(
                  height: 155,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF42E0FF),
                        Color(0xFFB8EEF8),
                        Color(0xFFE8F9FD),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
              ),
              const SafeArea(
                bottom: false,
                child: _TopBar(),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // ── Your Pet Section ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _SectionHeader(
              title: 'Your Pet',
              onSeeAll: onPetSeeAll,
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _PetCard(onQuickFeed: onQuickFeed),
          ),

          const SizedBox(height: 28),

          // ── Learning Track Section ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _SectionHeader(
              title: 'Learning Track',
              onSeeAll: onLearnSeeAll,
            ),
          ),
          const SizedBox(height: 14),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _LearningTrackCard(
              percent: 0.70,
              color: Color(0xFFFFC107),
              language: 'Javanese',
              region: 'West Sumatra, Indonesia',
              topic: 'Topic 2 : Javanese Etiquette 101.',
              note: '3 more words to unlock the next Topic',
            ),
          ),
          const SizedBox(height: 14),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _LearningTrackCard(
              percent: 0.50,
              color: Color(0xFFEF5350),
              language: 'Javanese',
              region: 'West Sumatra, Indonesia',
              topic: 'Topic 2 : Javanese Etiquette 101',
              note: '',
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TOP BAR
// ═══════════════════════════════════════════
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Avatar ──
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF42E0FF).withOpacity(0.5),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AppAssets.defaultAvatar,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF8C9EFF),
                  child: const Icon(Icons.face, color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // ── Greeting Text ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Welcome Back, Jhon',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF05354C),
                    letterSpacing: 0.1,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Keeping the vibes alive, one word at a time.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF05354C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // ── XP Badge ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFDFF5EF),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: const [
                Text(
                  '960',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF05354C),
                    height: 1,
                  ),
                ),
                SizedBox(width: 1),
                Text(
                  'xp',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9E9E9E),
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// PET CARD
// ═══════════════════════════════════════════
class _PetCard extends StatelessWidget {
  final VoidCallback onQuickFeed;

  const _PetCard({required this.onQuickFeed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ── Card Body ──
        Container(
          margin: const EdgeInsets.only(top: 28),
          padding: const EdgeInsets.fromLTRB(16, 68, 16, 20),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F6FA),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF42E0FF).withOpacity(0.12),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Name + Level Row ──
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 138),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name & Level
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Kaba The Buffalo',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A2E),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD0EEF8),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Lvl. 12',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5A7A90),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // ── Flag + Region ──
                        Row(
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Text(
                                  '🇮🇩',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Minang',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1A1A2E),
                                  ),
                                ),
                                Text(
                                  'West Sumatra, Indonesia',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF3A3A5C),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ── Chat Bubble ──
              Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF05354C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "I'm getting a bit hungry for some Minang\nwords... care to feed me?",
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.white,
                          height: 1.45,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Bubble tail (arrow pointing up-left)
                    Positioned(
                      top: -6,
                      left: 18,
                      child: Transform.rotate(
                        angle: pi / 4,
                        child: Container(
                          width: 12,
                          height: 12,
                          color: const Color(0xFF05354C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ── Stat Cards Row ──
              Row(
                children: const [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.apple,
                      iconColor: Color(0xFFF5A623),
                      label: 'Hunger',
                      percent: 0.15,
                      progressColor: Color(0xFFEF5350),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.favorite_border_rounded,
                      iconColor: Color(0xFFF5A623),
                      label: 'Hapinnes',
                      percent: 0.10,
                      progressColor: Color(0xFFEF5350),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.auto_awesome,
                      iconColor: Color(0xFF42E0FF),
                      label: 'Energy',
                      percent: 0.02,
                      progressColor: Color(0xFFB0BEC5),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Progress Label ──
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF05354C),
                    ),
                  ),
                  Text(
                    '75% to Next Evolution',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ── Progress Bar ──
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Stack(
                  children: [
                    Container(
                      height: 14,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.75,
                      child: Container(
                        height: 14,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFF5A623),
                              Color(0xFFF89B29),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ── Quick Feed Button ──
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: onQuickFeed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF89B29),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    'Quick Feed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Pet Image Floating (top-left overlap) ──
        Positioned(
          top: -14,
          left: -12,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 172,
                height: 172,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFF3E0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF89B29).withOpacity(0.18),
                      blurRadius: 22,
                      spreadRadius: 6,
                    ),
                  ],
                ),
              ),
              Image.asset(
                AppAssets.petBaby,
                width: 148,
                height: 148,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.pets,
                  size: 80,
                  color: Color(0xFFF89B29),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════
// STAT CARD
// ═══════════════════════════════════════════
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final double percent;
  final Color progressColor;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.percent,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: iconColor),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Stack(
              children: [
                Container(
                  height: 6,
                  width: double.infinity,
                  color: const Color(0xFFEEEEEE),
                ),
                FractionallySizedBox(
                  widthFactor: percent.clamp(0.0, 1.0),
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(percent * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF757575),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// LEARNING TRACK CARD
// ═══════════════════════════════════════════
class _LearningTrackCard extends StatelessWidget {
  final double percent;
  final Color color;
  final String language;
  final String region;
  final String topic;
  final String note;

  const _LearningTrackCard({
    required this.percent,
    required this.color,
    required this.language,
    required this.region,
    required this.topic,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7FB),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Circular Progress ──
          SizedBox(
            width: 72,
            height: 72,
            child: CustomPaint(
              painter: _CircularProgressPainter(
                percent: percent,
                color: color,
              ),
              child: Center(
                child: Text(
                  '${(percent * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Language Name
                Text(
                  language,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF05354C),
                  ),
                ),
                const SizedBox(height: 4),

                // Flag + Region
                Row(
                  children: [
                    const Text('🇮🇩', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        region,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF05354C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Topic Button
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B4D6C),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          topic,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // Note
                if (note.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      note,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// CIRCULAR PROGRESS PAINTER
// ═══════════════════════════════════════════
class _CircularProgressPainter extends CustomPainter {
  final double percent;
  final Color color;

  _CircularProgressPainter({required this.percent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 5;

    // Background track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 7
        ..style = PaintingStyle.stroke,
    );

    // Foreground arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * percent,
      false,
      Paint()
        ..color = color
        ..strokeWidth = 7
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter old) =>
      old.percent != percent || old.color != color;
}

// ═══════════════════════════════════════════
// SECTION HEADER
// ═══════════════════════════════════════════
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A1A2E),
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF6B8499),
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════
// BOTTOM NAV
// ═══════════════════════════════════════════
class _BottomNav extends StatelessWidget {
  final int current;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      decoration: const BoxDecoration(
        color: Color(0xFFDFF1FB),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A42E0FF),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home_filled, 'Home', 0),
            _buildNavItem(Icons.pets, 'Pets', 1),
            _buildNavItem(Icons.book, 'Learn', 2),
            _buildNavItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: isActive
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFB3DEFA),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: const Color(0xFF004D73), size: 22),
                  const SizedBox(width: 7),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF004D73),
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          : Icon(icon, size: 28, color: const Color(0xFF3A3A4A)),
    );
  }
}

// ═══════════════════════════════════════════
// HEADER WAVE CLIPPER
// ═══════════════════════════════════════════
class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 28);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height + 12,
      size.width * 0.5,
      size.height - 14,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 38,
      size.width,
      size.height - 8,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
