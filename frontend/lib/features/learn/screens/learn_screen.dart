import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/features/learn/screens/module_detail_screen.dart';
import 'package:lingupet/features/learn/screens/module_start_screen.dart';

// ═══════════════════════════════════════════
// LEARN SCREEN
// ═══════════════════════════════════════════
class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) => const _ModuleDiscoveryPage();
}

// ═══════════════════════════════════════════
// MODULE DISCOVERY PAGE
// ═══════════════════════════════════════════
class _ModuleDiscoveryPage extends StatefulWidget {
  const _ModuleDiscoveryPage();

  @override
  State<_ModuleDiscoveryPage> createState() => _ModuleDiscoveryPageState();
}

class _ModuleDiscoveryPageState extends State<_ModuleDiscoveryPage> {
  int _filterIndex = 0;

  static const List<_DiscoveryModule> _allModules = [
    _DiscoveryModule(
      bold: 'Minang',
      flag: '🇮🇩',
      region: 'West Sumatra, Indonesia',
      percent: 0.70,
      progressLabel: 'Continue: Greeting Elders',
      bgColor: Color(0xFFD4A843),
      petAsset: AppAssets.petBaby,
      status: 'progress',
    ),
    _DiscoveryModule(
      bold: 'Iban',
      flag: '🇲🇾',
      region: 'Sarawak, Malaysia',
      percent: 0.25,
      progressLabel: 'Continue: Greeting Elders',
      bgColor: Color(0xFF3D6B58),
      petAsset: AppAssets.petOrangUtanAnaknobg,
      status: 'progress',
    ),
    _DiscoveryModule(
      bold: 'Melayu-Brunei',
      flag: '🇧🇳',
      region: 'Brunei-Muara, Brunei Darussalam',
      percent: 1.0,
      progressLabel: 'Yeay, You Already Master',
      bgColor: Color(0xFF5A9E6F),
      petAsset: AppAssets.petKucing,
      status: 'mastered',
    ),
  ];

  List<_DiscoveryModule> get _filtered {
    if (_filterIndex == 1) {
      return _allModules.where((m) => m.status == 'progress').toList();
    }
    if (_filterIndex == 2) {
      return _allModules.where((m) => m.status == 'mastered').toList();
    }
    return _allModules;
  }

  @override
  Widget build(BuildContext context) {
    final modules = _filtered;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── HEADER DENGAN WAVE ──
          ClipPath(
            clipper: _HeaderWaveClipper(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF42E0FF), Color(0xFFF1F9FF), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ready to master a new Native Tongue, John?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF05354C),
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Keeping the vibes alive, one word at a time.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF05354C),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Module Discovery',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A2E)),
                ),
                const SizedBox(height: 12),

                // ── FILTER CHIPS ──
                Row(
                  children: [
                    _FilterChip(
                        label: 'All Languages',
                        active: _filterIndex == 0,
                        onTap: () => setState(() => _filterIndex = 0)),
                    const SizedBox(width: 8),
                    _FilterChip(
                        label: 'On progress',
                        active: _filterIndex == 1,
                        onTap: () => setState(() => _filterIndex = 1)),
                    const SizedBox(width: 8),
                    _FilterChip(
                        label: 'Mastered',
                        active: _filterIndex == 2,
                        onTap: () => setState(() => _filterIndex = 2)),
                  ],
                ),
                const SizedBox(height: 16),

                _PuzzleGrid(
                  modules: modules,
                  onAddNew: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const ModuleLibraryScreen()),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// CUSTOM CLIPPER: WAVE HEADER
// ═══════════════════════════════════════════
class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    // Gelombang halus (turun perlahan, lalu naik sedikit)
    path.quadraticBezierTo(
        size.width * 0.25, size.height + 10, 
        size.width * 0.5, size.height - 15);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 40, 
        size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ═══════════════════════════════════════════
// PUZZLE GRID
// ═══════════════════════════════════════════
class _PuzzleGrid extends StatelessWidget {
  final List<_DiscoveryModule> modules;
  final VoidCallback onAddNew;

  const _PuzzleGrid({required this.modules, required this.onAddNew});

  @override
  Widget build(BuildContext context) {
    final allItems = <Widget>[
      for (int i = 0; i < modules.length; i++)
        _DiscoveryCard(module: modules[i], col: i % 2),
      _AddNewCard(onTap: onAddNew),
    ];

    final rows = <Widget>[];
    for (int i = 0; i < allItems.length; i += 2) {
      final left = allItems[i];
      final right =
          i + 1 < allItems.length ? allItems[i + 1] : const SizedBox();
      rows.add(
        SizedBox(
          height: 210,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: left),
              const SizedBox(width: 4),
              Expanded(child: right),
            ],
          ),
        ),
      );
      if (i + 2 < allItems.length) rows.add(const SizedBox(height: 10));
    }

    return Column(children: rows);
  }
}

// ═══════════════════════════════════════════
// PUZZLE CLIPPER
// ═══════════════════════════════════════════
class _PuzzleClipper extends CustomClipper<Path> {
  final int col;
  const _PuzzleClipper(this.col);

  @override
  Path getClip(Size s) {
    const r = 16.0;
    const nb = 13.0;
    const nd = 16.0;
    final midY = s.height * 0.52;

    final p = Path();

    if (col == 0) {
      // Kiri — benjolan keluar di kanan
      p.moveTo(r, 0);
      p.lineTo(s.width - r, 0);
      p.arcToPoint(Offset(s.width, r), radius: const Radius.circular(r));
      p.lineTo(s.width, midY - nb);
      p.arcToPoint(Offset(s.width + nd, midY - nb),
          radius: Radius.circular(nb / 1.5), clockwise: false);
      p.arcToPoint(Offset(s.width + nd, midY + nb),
          radius: Radius.circular(nb), clockwise: true);
      p.arcToPoint(Offset(s.width, midY + nb),
          radius: Radius.circular(nb / 1.5), clockwise: false);
      p.lineTo(s.width, s.height - r);
      p.arcToPoint(Offset(s.width - r, s.height),
          radius: const Radius.circular(r));
      p.lineTo(r, s.height);
      p.arcToPoint(Offset(0, s.height - r),
          radius: const Radius.circular(r));
      p.lineTo(0, r);
      p.arcToPoint(Offset(r, 0), radius: const Radius.circular(r));
    } else {
      // Kanan — lubang masuk di kiri
      p.moveTo(r, 0);
      p.lineTo(s.width - r, 0);
      p.arcToPoint(Offset(s.width, r), radius: const Radius.circular(r));
      p.lineTo(s.width, s.height - r);
      p.arcToPoint(Offset(s.width - r, s.height),
          radius: const Radius.circular(r));
      p.lineTo(r, s.height);
      p.arcToPoint(Offset(0, s.height - r),
          radius: const Radius.circular(r));
      p.lineTo(0, midY + nb);
      p.arcToPoint(Offset(-nd + nb, midY + nb),
          radius: Radius.circular(nb / 1.5), clockwise: false);
      p.arcToPoint(Offset(-nd + nb, midY - nb),
          radius: Radius.circular(nb), clockwise: true);
      p.arcToPoint(Offset(0, midY - nb),
          radius: Radius.circular(nb / 1.5), clockwise: false);
      p.lineTo(0, r);
      p.arcToPoint(Offset(r, 0), radius: const Radius.circular(r));
    }

    p.close();
    return p;
  }

  @override
  bool shouldReclip(_PuzzleClipper o) => o.col != col;
}

// ═══════════════════════════════════════════
// DISCOVERY CARD
// ═══════════════════════════════════════════
class _DiscoveryCard extends StatelessWidget {
  final _DiscoveryModule module;
  final int col;

  const _DiscoveryCard({required this.module, required this.col});

  @override
  Widget build(BuildContext context) {
    final barColor = module.percent >= 1.0
        ? const Color(0xFF4CAF50)
        : module.percent >= 0.6
            ? const Color(0xFFF5A623)
            : const Color(0xFF4CAF50);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ModuleDetailScreen(
            moduleName: module.bold,
            flag: module.flag,
            region: module.region,
            petAsset: module.petAsset,
            bgColor: module.bgColor,
          ),
        ),
      ),
      child: ClipPath(
        clipper: _PuzzleClipper(col),
        child: Container(
          decoration: BoxDecoration(
            color: module.bgColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.14),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ── TEKS ──
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mastering',
                        style:
                            TextStyle(fontSize: 11, color: Colors.white70)),
                    Text(module.bold,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white)),
                    const Text('Language',
                        style: TextStyle(
                            fontSize: 12, color: Colors.white)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(module.flag,
                            style: const TextStyle(fontSize: 12)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(module.region,
                              style: const TextStyle(
                                  fontSize: 9.5, color: Colors.white70),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: module.percent,
                        minHeight: 6,
                        backgroundColor:
                            Colors.white.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation(barColor),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${(module.percent * 100).toInt()} %',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    Text(module.progressLabel,
                        style: const TextStyle(
                            fontSize: 9.5, color: Colors.white70)),
                  ],
                ),
              ),

              // ── PET IMAGE ──
              Positioned(
                bottom: -14,
                left: col == 0 ? 0 : 4,
                child: Image.asset(
                  module.petAsset,
                  height: 95,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const SizedBox(height: 95),
                ),
              ),

              // ── PLAY BUTTON → ModuleStartScreen ──
              Positioned(
                bottom: 10,
                right: 12,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ModuleStartScreen(
                        moduleName: module.bold,
                        flag: module.flag,
                        region: module.region,
                        petAsset: module.petAsset,
                        bgColor: module.bgColor,
                        percent: module.percent,
                      ),
                    ),
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Icon(Icons.play_arrow_rounded,
                        size: 24, color: module.bgColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// ADD NEW CARD
// ═══════════════════════════════════════════
class _AddNewCard extends StatelessWidget {
  final VoidCallback onTap;
  const _AddNewCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD6EEF8),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: const Color(0xFF38D1F5).withOpacity(0.3),
              width: 1.5),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline_rounded,
                size: 48, color: Color(0xFF38D1F5)),
            SizedBox(height: 10),
            Text('Add a New Language',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2A5298))),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// FILTER CHIP
// ═══════════════════════════════════════════
class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _FilterChip(
      {required this.label,
      required this.active,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF38D1F5) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 1))
          ],
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : const Color(0xFF6B8499))),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// MODULE LIBRARY SCREEN
// ═══════════════════════════════════════════
class ModuleLibraryScreen extends StatefulWidget {
  const ModuleLibraryScreen({super.key});

  @override
  State<ModuleLibraryScreen> createState() => _ModuleLibraryScreenState();
}

class _ModuleLibraryScreenState extends State<ModuleLibraryScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  final Set<String> _expanded = {'Brunei Darussalam', 'Indonesia'};

  static const List<_CountryData> _countries = [
    _CountryData(
      flag: '🇧🇳',
      name: 'Brunei Darussalam',
      count: 5,
      modules: [
        _ModuleItem(bold: 'Melayu-Brunei', region: 'Brunei-Muara', color: Color(0xFFFFF3E0), petAsset: AppAssets.petTeen),
        _ModuleItem(bold: 'Tutong',        region: 'Tutong',        color: Color(0xFFE3F2FD), petAsset: AppAssets.petBaby),
        _ModuleItem(bold: 'Melayu-Brunei', region: 'Brunei-Muara', color: Color(0xFFFFF3E0), petAsset: AppAssets.petTeen),
        _ModuleItem(bold: 'Melayu-Brunei', region: 'Brunei-Muara', color: Color(0xFFFFF3E0), petAsset: AppAssets.petTeen),
        _ModuleItem(bold: 'Tutong',        region: 'Tutong',        color: Color(0xFFE3F2FD), petAsset: AppAssets.petBaby),
      ],
    ),
    _CountryData(flag: '🇵🇭', name: 'Filipina', count: 180, modules: []),
    _CountryData(
      flag: '🇮🇩',
      name: 'Indonesia',
      count: 450,
      modules: [
        _ModuleItem(bold: 'Minang',   region: 'West Sumatra', color: Color(0xFFFFF3E0), petAsset: AppAssets.petAdult),
        _ModuleItem(bold: 'Javanese', region: 'East Jawa',    color: Color(0xFFE3F2FD), petAsset: AppAssets.petTeen),
        _ModuleItem(bold: 'Minang',   region: 'West Sumatra', color: Color(0xFFFFF3E0), petAsset: AppAssets.petAdult),
      ],
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _toggle(String name) => setState(() {
        _expanded.contains(name)
            ? _expanded.remove(name)
            : _expanded.add(name);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6FB),
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER ──
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB8E4F5), Color(0xFFE8F6FB)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.close_rounded,
                              size: 18, color: Color(0xFF1A1A2E)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'The Heritage Lab: Create Something New!',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A2E)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Search bar
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: TextField(
                      controller: _searchCtrl,
                      style: const TextStyle(fontSize: 13),
                      decoration: const InputDecoration(
                        hintText:
                            'Search for Country, Language or Region',
                        hintStyle: TextStyle(
                            color: Color(0xFFB0BEC5), fontSize: 13),
                        prefixIcon: Icon(Icons.search_rounded,
                            color: Color(0xFFB0BEC5), size: 20),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── BODY ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Module Library',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1A1A2E))),
                    const SizedBox(height: 12),
                    for (final c in _countries)
                      _CountryAccordion(
                        data: c,
                        isExpanded: _expanded.contains(c.name),
                        onToggle: () => _toggle(c.name),
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// COUNTRY ACCORDION
// ═══════════════════════════════════════════
class _CountryAccordion extends StatelessWidget {
  final _CountryData data;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _CountryAccordion(
      {required this.data,
      required this.isExpanded,
      required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Row(
              children: [
                Text(data.flag,
                    style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.name,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A2E))),
                      Text('${data.count} Regional Languages',
                          style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF6B8499))),
                    ],
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: const Color(0xFF6B8499),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded && data.modules.isNotEmpty) ...[
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.72,
            ),
            itemCount: data.modules.length,
            itemBuilder: (_, i) =>
                _ModuleCard(item: data.modules[i]),
          ),
          const SizedBox(height: 12),
        ] else
          const SizedBox(height: 6),
      ],
    );
  }
}

// ═══════════════════════════════════════════
// MODULE CARD (library 3-col)
// ═══════════════════════════════════════════
class _ModuleCard extends StatelessWidget {
  final _ModuleItem item;
  const _ModuleCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mastering',
              style: TextStyle(
                  fontSize: 9.5, color: Color(0xFF8A9BB0))),
          Text(item.bold,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E))),
          const Text('Language',
              style: TextStyle(
                  fontSize: 10, color: Color(0xFF1A1A2E))),
          const SizedBox(height: 2),
          Text('Region: ${item.region}',
              style: const TextStyle(
                  fontSize: 8.5, color: Color(0xFF6B8499))),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              item.petAsset,
              height: 52,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                  Icons.pets_rounded,
                  size: 32,
                  color: const Color(0xFFF5A623).withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// DATA MODELS
// ═══════════════════════════════════════════
class _CountryData {
  final String flag, name;
  final int count;
  final List<_ModuleItem> modules;

  const _CountryData(
      {required this.flag,
      required this.name,
      required this.count,
      required this.modules});
}

class _ModuleItem {
  final String bold, region, petAsset;
  final Color color;

  const _ModuleItem(
      {required this.bold,
      required this.region,
      required this.color,
      required this.petAsset});
}

class _DiscoveryModule {
  final String bold, flag, region, progressLabel, petAsset, status;
  final double percent;
  final Color bgColor;

  const _DiscoveryModule({
    required this.bold,
    required this.flag,
    required this.region,
    required this.percent,
    required this.progressLabel,
    required this.bgColor,
    required this.petAsset,
    required this.status,
  });
}