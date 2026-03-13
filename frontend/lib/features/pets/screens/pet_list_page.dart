import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/features/pets/screens/add_language_screen.dart';

// ═══════════════════════════════════════════
// DATA MODEL
// ═══════════════════════════════════════════
class _PetItem {
  final String imageAsset;
  final String name;
  final String location;
  final double progress;
  final int level;
  final int vocabularyCount;
  final int audioCount;
  final int contributorCount;
  final String stageName;

  const _PetItem({
    required this.imageAsset,
    required this.name,
    required this.location,
    required this.progress,
    this.level = 20,
    this.vocabularyCount = 0,
    this.audioCount = 0,
    this.contributorCount = 0,
    this.stageName = 'Mature',
  });
}

class _CountryData {
  final String name;
  final String flagEmoji;
  final List<_PetItem> pets;

  const _CountryData({
    required this.name,
    required this.flagEmoji,
    required this.pets,
  });

  String get subtitle => '${pets.length} local language${pets.length > 1 ? 's' : ''}';
}

final _countries = [
  _CountryData(
    name: 'Indonesia',
    flagEmoji: '🇮🇩',
    pets: [
      _PetItem(
        imageAsset: AppAssets.petAdultBg,
        name: 'Kaba The Buffalo',
        location: 'West Sumatra, Indonesia',
        progress: 0.75,
        level: 20,
        vocabularyCount: 1234,
        audioCount: 890,
        contributorCount: 156,
        stageName: 'Mature',
      ),
      _PetItem(
        imageAsset: AppAssets.petBurung,
        name: 'Jali the Speaker',
        location: 'Bali, Indonesia',
        progress: 0.75,
        level: 20,
        vocabularyCount: 1234,
        audioCount: 890,
        contributorCount: 156,
        stageName: 'Mature',
      ),
    ],
  ),
  _CountryData(
    name: 'Malaysia',
    flagEmoji: '🇲🇾',
    pets: [
      _PetItem(
        imageAsset: AppAssets.petOrangUtanRemaja,
        name: 'Oru The Borneo',
        location: 'Sarawak, Malaysia',
        progress: 0.75,
        level: 20,
        vocabularyCount: 1234,
        audioCount: 890,
        contributorCount: 156,
        stageName: 'Mature',
      ),
    ],
  ),
];

// ═══════════════════════════════════════════
// PET LIST PAGE
// ═══════════════════════════════════════════
class PetListPage extends StatefulWidget {
  const PetListPage({Key? key}) : super(key: key);

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  final TextEditingController _searchController = TextEditingController();
  late Set<String> _expandedCountries;
  List<_CountryData> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _expandedCountries = {'Indonesia', 'Malaysia'};
    _filteredCountries = _countries;
    _searchController.addListener(_filterCountries);
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCountries = _countries.where((c) {
        final matchCountry = c.name.toLowerCase().contains(query);
        final matchPet = c.pets.any(
          (p) =>
              p.name.toLowerCase().contains(query) ||
              p.location.toLowerCase().contains(query),
        );
        return matchCountry || matchPet;
      }).toList();
    });
  }

  void _toggleCountry(String name) {
    setState(() {
      if (_expandedCountries.contains(name)) {
        _expandedCountries.remove(name);
      } else {
        _expandedCountries.add(name);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          // ── 1. MAIN SCROLLABLE CONTENT ──
          Column(
            children: [
              // ── Header ──
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
                        Colors.white
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.6, 1.0],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          const Text(
                            'Pet List',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF05354C),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Choose and take care of the local dialect you\nwant to grow.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF616161),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Search Bar
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: const Color(0xFFEAEAEA)),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search country or region...',
                            hintStyle: const TextStyle(
                                color: Color(0xFF9E9E9E), fontSize: 14),
                            prefixIcon: const Icon(Icons.search,
                                color: Color(0xFF05354C), size: 20),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear,
                                        color: Color(0xFF9E9E9E), size: 18),
                                    onPressed: () {
                                      _searchController.clear();
                                      _filterCountries();
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── List ──
              Expanded(
                child: _filteredCountries.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 8, bottom: 120),
                        itemCount: _filteredCountries.length,
                        itemBuilder: (_, i) {
                          final country = _filteredCountries[i];
                          final isExpanded =
                              _expandedCountries.contains(country.name);
                          final hasPets = country.pets.isNotEmpty;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildCountrySection(
                              country: country,
                              isExpanded: isExpanded && hasPets,
                              hasPets: hasPets,
                              onToggle: hasPets
                                  ? () => _toggleCountry(country.name)
                                  : null,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),

          // ── 2. BOTTOM NAV BAR (deklarasi sebelum FAB) ──
          // ✅ FIX: Nav bar di deklarasi SEBELUM FAB agar FAB berada di layer atas
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 85,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFE6F5FE),
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
                    const Icon(Icons.home_filled,
                        size: 30, color: Colors.black87),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBBE5FB),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.pets, color: Color(0xFF004D73), size: 24),
                          SizedBox(width: 8),
                          Text('Pet',
                              style: TextStyle(
                                  color: Color(0xFF004D73),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ],
                      ),
                    ),
                    const Icon(Icons.book, size: 28, color: Colors.black87),
                    const Icon(Icons.person, size: 30, color: Colors.black87),
                  ],
                ),
              ),
            ),
          ),

          // ── 3. FAB (deklarasi TERAKHIR = layer paling atas) ──
          // ✅ FIX: FAB di deklarasi SETELAH nav bar agar tidak tertutup
          Positioned(
            bottom: 105,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFBBE5FB).withOpacity(0.5),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddLanguageScreen()),
                  );
                },
                icon: const Icon(Icons.add, size: 20, color: Color(0xFF05354C)),
                label: const Text(
                  'Add Languages',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF05354C),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBBE5FB),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_rounded,
              size: 64, color: Color(0xFFB0BEC5)),
          const SizedBox(height: 16),
          const Text(
            'No results found',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF607D8B)),
          ),
          const SizedBox(height: 8),
          Text('Try a different keyword',
              style: TextStyle(fontSize: 13, color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildCountrySection({
    required _CountryData country,
    required bool isExpanded,
    required bool hasPets,
    VoidCallback? onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                _buildFlagCircle(country.flagEmoji),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        country.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      Text(
                        country.subtitle,
                        style: const TextStyle(
                            fontSize: 13, color: Color(0xFF757575)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFEAEAEA)),
                  ),
                  child: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: hasPets
                        ? const Color(0xFF9E9E9E)
                        : const Color(0xFFCCCCCC),
                  ),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Column(
              children: [
                const SizedBox(height: 16),
                ...country.pets.asMap().entries.map((e) => Padding(
                      padding: EdgeInsets.only(
                          bottom: e.key < country.pets.length - 1 ? 12 : 0),
                      child: _buildPetCard(e.value),
                    )),
              ],
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(_PetItem pet) {
    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 85,
            height: 85,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFCDD2).withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(pet.imageAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -4,
                  right: -4,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1EA3B8),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '${pet.level}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        pet.name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.local_fire_department,
                              color: Color(0xFFE65100), size: 12),
                          SizedBox(width: 2),
                          Text('Master',
                              style: TextStyle(
                                  color: Color(0xFFE65100),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: Color(0xFF757575), size: 14),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        pet.location,
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF757575)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1EA3B8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.pets, color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(pet.stageName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Progress',
                        style: TextStyle(
                            fontSize: 12, color: Color(0xFF757575))),
                    Text(
                      '${(pet.progress * 100).toInt()}%',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Stack(
                  children: [
                    Container(
                      height: 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: pet.progress,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1EA3B8),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatIcon(
                        Icons.article_outlined, '${pet.vocabularyCount}'),
                    _buildStatIcon(
                        Icons.volume_up_outlined, '${pet.audioCount}'),
                    _buildStatIcon(
                        Icons.group_outlined, '${pet.contributorCount}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlagCircle(String emoji) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
          color: Color(0xFFE6F5FE), shape: BoxShape.circle),
      child: Center(
          child: Text(emoji, style: const TextStyle(fontSize: 24))),
    );
  }

  Widget _buildStatIcon(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF9E9E9E), size: 14),
        const SizedBox(width: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF757575),
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// ═══════════════════════════════════════════
// WAVE CLIPPER
// ═══════════════════════════════════════════
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
