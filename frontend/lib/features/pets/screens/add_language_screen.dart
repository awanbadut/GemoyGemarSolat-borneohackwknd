import 'package:flutter/material.dart';
import 'package:lingupet/features/pets/screens/tell_us_language_screen.dart';

class AddLanguageScreen extends StatefulWidget {
  const AddLanguageScreen({super.key});

  @override
  State<AddLanguageScreen> createState() => _AddLanguageScreenState();
}

class _AddLanguageScreenState extends State<AddLanguageScreen> {
  final TextEditingController _searchController = TextEditingController();

  // ✅ null = belum pilih negara
  int? _selectedIndex;

  final List<Map<String, String>> _countries = [
    {'name': 'Indonesia', 'subtitle': '1 local languages', 'flag': '🇮🇩'},
    {'name': 'Malaysia', 'subtitle': '1 local languages', 'flag': '🇲🇾'},
    {'name': 'Thailand', 'subtitle': '3 local languages', 'flag': '🇹🇭'},
    {'name': 'Philippines', 'subtitle': '3 local languages', 'flag': '🇵🇭'},
    {'name': 'Laos', 'subtitle': '3 local languages', 'flag': '🇱🇦'},
    {'name': 'Myanmar', 'subtitle': '3 local languages', 'flag': '🇲🇲'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ true jika sudah pilih negara
    final bool hasSelected = _selectedIndex != null;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          // ── MAIN CONTENT (Header + List) ──
          Column(
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
                          const Text(
                            'Add Language',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF05354C),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Choose a country where the languange is spoken.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF05354C),
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
                              color: Colors.black.withOpacity(0.04),
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

              // LIST NEGARA
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 100),
                  itemCount: _countries.length,
                  itemBuilder: (context, index) {
                    final country = _countries[index];
                    final isSelected = _selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEDF9FE)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF38D1F5)
                                : const Color(0xFFEAEAEA),
                            width: isSelected ? 2.0 : 1.0,
                          ),
                          boxShadow: [
                            if (!isSelected)
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Flag Circle
                            Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE6F5FE),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  country['flag']!,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Country Text Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    country['name']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1A1A2E),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    country['subtitle']!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF757575),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // ── FLOATING BUTTON ──
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
                  // ✅ Shadow hanya muncul saat aktif (orange)
                  boxShadow: hasSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFFF89B29).withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: ElevatedButton(
                  // ✅ onPressed null = tombol disabled saat belum pilih
                  onPressed: hasSelected
                      ? () {
                          final selected = _countries[_selectedIndex!];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TellUsLanguageScreen(
                                countryName: selected['name']!,
                                countryFlag: selected['flag']!,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    // ✅ Orange jika sudah pilih, abu-abu jika belum
                    backgroundColor: hasSelected
                        ? const Color(0xFFF89B29)
                        : const Color(0xFFBDBDBD),
                    disabledBackgroundColor: const Color(0xFFBDBDBD),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Countinue',
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
}

// ═══════════════════════════════════════════
// CLIPPER: HEADER WAVE
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
