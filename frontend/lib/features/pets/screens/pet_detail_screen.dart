import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/features/pets/screens/build_vocabulary_page.dart';
import 'package:lingupet/features/pets/screens/language_dictionary_page.dart';
import 'package:lingupet/features/pets/screens/pet_detail_page.dart';
import 'package:lingupet/features/pets/screens/pet_list_page.dart';

// ═══════════════════════════════════════════
// DATA MODEL
// ═══════════════════════════════════════════
class _Pet {
  final String name;
  final String region;
  final String flag;
  final String bgAsset;
  final int level;
  final double progress;
  final double hunger;
  final double happiness;
  final double energy;
  final Color nameColor;
  final String language;
  final int vocabularyCount;
  final int audioCount;
  final int contributorCount;
  final String stageName;
  final String stageDescription;
  final int nextLevelRequired;
  final int nextVocabRequired;
  final int nextAudioRequired;
  final String accent;

  const _Pet({
    required this.name,
    required this.region,
    required this.flag,
    required this.bgAsset,
    required this.level,
    required this.progress,
    required this.hunger,
    required this.happiness,
    required this.energy,
    required this.language,
    this.nameColor = const Color(0xFF1A1A1A),
    this.vocabularyCount = 0,
    this.audioCount = 0,
    this.contributorCount = 0,
    this.stageName = 'Baby',
    this.stageDescription = '',
    this.nextLevelRequired = 10,
    this.nextVocabRequired = 100,
    this.nextAudioRequired = 50,
    this.accent = '',
  });
}

const _petList = [
  _Pet(
    name: 'Kaba The Buffalo',
    region: 'West Sumatra, Indonesia',
    flag: '🇮🇩',
    bgAsset: AppAssets.petBabyBg,
    level: 5,
    progress: 0.25,
    hunger: 0.85,
    happiness: 0.90,
    energy: 0.75,
    language: 'Minang Language',
    nameColor: Color(0xFF1A1A1A),
    vocabularyCount: 1574,
    audioCount: 890,
    contributorCount: 156,
    stageName: 'Baby',
    stageDescription: 'A well-established dialect with many speakers and a rich vocabulary.',
    nextLevelRequired: 65,
    nextVocabRequired: 1300,
    nextAudioRequired: 975,
    accent: 'Minang with an authentic Minang accent',
  ),
  _Pet(
    name: 'Oru the Borneo',
    region: 'Sarawak, Malaysia',
    flag: '🇲🇾',
    bgAsset: AppAssets.petOrangUtanAnak,
    level: 5,
    progress: 0.25,
    hunger: 0.85,
    happiness: 0.90,
    energy: 0.75,
    language: 'Borneo Language',
    nameColor: Colors.white,
    vocabularyCount: 843,
    audioCount: 412,
    contributorCount: 78,
    stageName: 'Baby',
    stageDescription: 'A developing dialect with growing community contributions.',
    nextLevelRequired: 65,
    nextVocabRequired: 1300,
    nextAudioRequired: 975,
    accent: 'Borneo with an authentic Dayak accent',
  ),
];

final _totalPages = _petList.length + 1;

// ═══════════════════════════════════════════
// PET DETAIL SCREEN
// ═══════════════════════════════════════════
class PetDetailScreen extends StatefulWidget {
  const PetDetailScreen({super.key});

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  final _ctrl = PageController();
  int _current = 0;

  late List<double> _hunger;
  late List<double> _happiness;
  late List<double> _energy;

  @override
  void initState() {
    super.initState();
    _hunger = _petList.map((p) => p.hunger).toList();
    _happiness = _petList.map((p) => p.happiness).toList();
    _energy = _petList.map((p) => p.energy).toList();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ FIX 1: Wrap dengan Material(color: transparent)
    // Ini menghilangkan garis kuning pada semua Text di dalamnya
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // ── Swipeable pages ──
          PageView.builder(
            controller: _ctrl,
            itemCount: _totalPages,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) {
              if (i == _petList.length) {
                return _RaiseAnotherPetPage(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PetListPage()),
                  ),
                );
              }
              return _PetPage(
                pet: _petList[i],
                hunger: _hunger[i],
                happiness: _happiness[i],
                energy: _energy[i],
                onFeed: (dH, dHa, dE) => setState(() {
                  _hunger[i] = (_hunger[i] + dH).clamp(0.0, 1.0);
                  _happiness[i] = (_happiness[i] + dHa).clamp(0.0, 1.0);
                  _energy[i] = (_energy[i] + dE).clamp(0.0, 1.0);
                }),
              );
            },
          ),

          // ── Dot indicators ──
          // ✅ FIX 2: bottom: 96 agar tidak tertutup bottom nav (85px)
          Positioned(
            bottom: 96,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_totalPages, (i) {
                final active = i == _current;
                final isLast = i == _petList.length;
                return GestureDetector(
                  onTap: () => _ctrl.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: active ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: active
                          ? (isLast ? const Color(0xFFFDB913) : Colors.white)
                          : (isLast
                              ? const Color(0xFFFDB913).withOpacity(0.4)
                              : Colors.white.withOpacity(0.45)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// RAISE ANOTHER PET PAGE
// ═══════════════════════════════════════════
class _RaiseAnotherPetPage extends StatelessWidget {
  final VoidCallback onTap;

  const _RaiseAnotherPetPage({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFB8E4F5),
            Color(0xFFD6EFF8),
            Color(0xFFEAF6FC),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: _WaveClipper(),
              child: Container(
                height: 40,
                color: const Color(0xFF9AD8F0).withOpacity(0.5),
              ),
            ),
            const Spacer(flex: 1),
            Image.asset(
              AppAssets.binggung,
              width: 260,
              height: 280,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Text('🐻', style: TextStyle(fontSize: 120)),
            ),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: const [
                  Text(
                    'Raise Another Pet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFF5A623),
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Grow another pet and help introduce and develop local languages together. Each pet represents a regional language you can learn, practice, and share with others. By raising more pets, you help keep these languages alive and connect with different cultures.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A6070),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5A623),
                    foregroundColor: Colors.white,
                    elevation: 6,
                    shadowColor: const Color(0xFFF5A623).withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: const Text(
                    "Let's Raise Another Pet",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
            // ✅ FIX 3: SizedBox tinggi 100 agar button tidak tertutup nav bar
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// SINGLE PET PAGE
// ═══════════════════════════════════════════
class _PetPage extends StatelessWidget {
  final _Pet pet;
  final double hunger;
  final double happiness;
  final double energy;
  final void Function(double dH, double dHa, double dE) onFeed;

  const _PetPage({
    required this.pet,
    required this.hunger,
    required this.happiness,
    required this.energy,
    required this.onFeed,
  });

  PetDetailData _toDetailData() => PetDetailData(
        name: pet.name,
        region: pet.region,
        flag: pet.flag,
        bgAsset: pet.bgAsset,
        language: pet.language,
        level: pet.level,
        progress: pet.progress,
        vocabularyCount: pet.vocabularyCount,
        audioCount: pet.audioCount,
        contributorCount: pet.contributorCount,
        stageName: pet.stageName,
        stageDescription: pet.stageDescription,
        nextLevelRequired: pet.nextLevelRequired,
        nextVocabRequired: pet.nextVocabRequired,
        nextAudioRequired: pet.nextAudioRequired,
        accent: pet.accent,
      );

  @override
  Widget build(BuildContext context) {
    final isDark = pet.nameColor == Colors.white;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background
        Image.asset(
          pet.bgAsset,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF1A3A2A), const Color(0xFF2D5A3D)]
                    : [const Color(0xFFFDE4D3), const Color(0xFFFFD6E0)],
              ),
            ),
          ),
        ),

        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),

              // Top Pills
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _TopPill(
                      icon: Icons.remove_red_eye_outlined,
                      label: 'Detail',
                      iconColor: const Color(0xFF0066CC),
                      textColor: const Color(0xFF0066CC),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PetDetailPage(data: _toDetailData()),
                        ),
                      ),
                    ),
                    _TopPill(
                      icon: Icons.emoji_events_outlined,
                      label: 'Level ${pet.level}',
                      iconColor: const Color(0xFF333333),
                      textColor: const Color(0xFF333333),
                      onTap: null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Pet Name
              Text(
                pet.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: pet.nameColor,
                  shadows: const [
                    Shadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              // Region
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(pet.flag, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 5),
                  Text(
                    pet.region,
                    style: TextStyle(
                      fontSize: 13,
                      color: pet.nameColor.withOpacity(0.9),
                      shadows: const [Shadow(color: Colors.black26, blurRadius: 6)],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Stat Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.local_fire_department_rounded,
                        iconColor: const Color(0xFFFF9800),
                        label: 'Hunger',
                        value: hunger,
                        barColor: const Color(0xFFFF9800),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.favorite_rounded,
                        iconColor: const Color(0xFFE91E63),
                        label: 'Happiness',
                        value: happiness,
                        barColor: const Color(0xFFE91E63),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.bolt_rounded,
                        iconColor: const Color(0xFF00A8CC),
                        label: 'Energy',
                        value: energy,
                        barColor: const Color(0xFF00A8CC),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Bottom Actions
              // ✅ FIX 4: bottom: 100 agar tidak tertutup bottom nav (85px)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _ActionButton(
                            icon: Icons.apple_rounded,
                            emoji: '🍎',
                            label: 'Feed',
                            bgColor: const Color(0xFFFDB913),
                            textColor: Colors.white,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BuildVocabularyPage(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ActionButton(
                            icon: Icons.menu_book_rounded,
                            emoji: '📖',
                            label: 'Vocabulary',
                            bgColor: const Color(0xFF1A3A5C),
                            textColor: Colors.white,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LanguageDictionaryPage(
                                  petName: pet.name,
                                  languageName: pet.language,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Level Progress Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Level Progress',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                              Text(
                                '${(pet.progress * 100).toInt()}%',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFF6B6B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: pet.progress,
                              minHeight: 10,
                              backgroundColor: const Color(0xFFE5E5E5),
                              valueColor: const AlwaysStoppedAnimation(Color(0xFFFDB913)),
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
    );
  }

  void _showFeedSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Feed ${pet.name.split(' ').first}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF011E2F),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Choose a food item to feed your pet',
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _FoodItem(emoji: '🍖', name: 'Meat', xp: '+15 XP', onTap: () { onFeed(0.30, 0.10, 0.00); Navigator.pop(context); })),
                const SizedBox(width: 8),
                Expanded(child: _FoodItem(emoji: '🌾', name: 'Grain', xp: '+8 XP', onTap: () { onFeed(0.15, 0.00, 0.00); Navigator.pop(context); })),
                const SizedBox(width: 8),
                Expanded(child: _FoodItem(emoji: '🍎', name: 'Fruit', xp: '+10 XP', onTap: () { onFeed(0.20, 0.05, 0.10); Navigator.pop(context); })),
                const SizedBox(width: 8),
                Expanded(child: _FoodItem(emoji: '🫙', name: 'Premium', xp: '+30 XP', onTap: () { onFeed(0.50, 0.30, 0.20); Navigator.pop(context); })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// WAVE CLIPPER
// ═══════════════════════════════════════════
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.quadraticBezierTo(size.width * 0.25, size.height, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.75, 0, size.width, size.height * 0.6);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> old) => false;
}

// ═══════════════════════════════════════════
// REUSABLE WIDGETS
// ═══════════════════════════════════════════
class _TopPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color textColor;
  final VoidCallback? onTap;

  const _TopPill({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final double value;
  final Color barColor;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF555555))),
          ]),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 7,
              backgroundColor: const Color(0xFFE5E5E5),
              valueColor: AlwaysStoppedAnimation(barColor),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${(value * 100).toInt()}%',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String emoji;
  final String label;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.emoji,
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: bgColor.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textColor)),
          ],
        ),
      ),
    );
  }
}

class _FoodItem extends StatelessWidget {
  final String emoji;
  final String name;
  final String xp;
  final VoidCallback onTap;

  const _FoodItem({
    required this.emoji,
    required this.name,
    required this.xp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 4),
            Text(name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
            const SizedBox(height: 2),
            Text(xp, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF10B981))),
          ],
        ),
      ),
    );
  }
}
