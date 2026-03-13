import 'dart:math';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════
// MODEL
// ═══════════════════════════════════════════
class VocabularyWord {
  final String word;
  final String translation;
  final String example;
  final String exampleTranslation;
  final String addedBy;
  final String addedByInitial;
  final int likes;
  final int accurateVotes;
  final int needsReviewVotes;
  final String infoNote;
  final bool isAccurate;

  VocabularyWord({
    required this.word,
    required this.translation,
    this.example = '',
    this.exampleTranslation = '',
    required this.addedBy,
    required this.addedByInitial,
    this.likes = 0,
    this.accurateVotes = 0,
    this.needsReviewVotes = 0,
    this.infoNote = '',
    this.isAccurate = true,
  });
}

// ═══════════════════════════════════════════
// PAGE
// ═══════════════════════════════════════════
class LanguageDictionaryPage extends StatefulWidget {
  final String petName;
  final String languageName;

  const LanguageDictionaryPage({
    Key? key,
    this.petName = 'Kaba The Buffalo',
    this.languageName = 'Minang Language',
  }) : super(key: key);

  @override
  State<LanguageDictionaryPage> createState() => _LanguageDictionaryPageState();
}

class _LanguageDictionaryPageState extends State<LanguageDictionaryPage> {
  int _selectedChipIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  int? _expandedIndex;
  bool _isPlaying = false;

  final List<VocabularyWord> _allWords = [
    VocabularyWord(
      word: 'Sila',
      translation: 'Please / Go ahead',
      example: '"Sila singgah, indak ado nan malarang doh."',
      exampleTranslation:
          '(Please come in / feel free to stop by, no one is stopping you.)',
      addedBy: 'Budi Santoso',
      addedByInitial: 'B',
      likes: 234,
      accurateVotes: 124,
      needsReviewVotes: 23,
      infoNote:
          'This word is commonly used in everyday informal conversations with friends.',
      isAccurate: true,
    ),
    VocabularyWord(
      word: 'Iyo',
      translation: 'Yes',
      addedBy: 'Rina Putri',
      addedByInitial: 'R',
      likes: 189,
      accurateVotes: 98,
      needsReviewVotes: 5,
      isAccurate: true,
    ),
    VocabularyWord(
      word: 'Baa',
      translation: 'How',
      addedBy: 'Andi Kurnia',
      addedByInitial: 'A',
      likes: 97,
      accurateVotes: 60,
      needsReviewVotes: 12,
      isAccurate: true,
    ),
  ];

  List<VocabularyWord> _filteredWords = [];
  final List<String> _chips = ['All Languages', 'Pupoller', 'Verified'];

  @override
  void initState() {
    super.initState();
    _filteredWords = _allWords;
    _searchController.addListener(_filterWords);
  }

  void _filterWords() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredWords = _allWords
          .where((w) =>
              w.word.toLowerCase().contains(query) ||
              w.translation.toLowerCase().contains(query))
          .toList();
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
      backgroundColor: const Color(0xFFF5FBFD),
      body: Column(
        children: [
          // ── HEADER ──
          ClipPath(
            clipper: DictionaryHeaderClipper(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 52, left: 24, right: 24, bottom: 44),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF42E0FF),
                    Color(0xFFB8EEF8),
                    Color(0xFFEAF8FD),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.55, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.arrow_back,
                              color: Color(0xFF00334E), size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Language Dictionary',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF05354C),
                            ),
                          ),
                          Text(
                            widget.languageName,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4A7A90),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // ── Search Bar ──
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFF1A1A2E)),
                      decoration: InputDecoration(
                        hintText: 'Cari negara atau daerah...',
                        hintStyle: const TextStyle(
                            color: Color(0xFFB0BEC5), fontSize: 14),
                        prefixIcon: const Icon(Icons.search,
                            color: Color(0xFF9E9E9E), size: 20),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear,
                                    color: Color(0xFF9E9E9E), size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterWords();
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

          // ── FILTER CHIPS ──
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
            child: Column(
              children: [
                Row(
                  children: List.generate(
                    _chips.length,
                    (i) => Padding(
                      padding: EdgeInsets.only(
                          right: i < _chips.length - 1 ? 12 : 0),
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _selectedChipIndex = i),
                        child: _buildChip(_chips[i],
                            isSelected: _selectedChipIndex == i),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // ── Words Found + Pet Name ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_filteredWords.length} Words Found',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF757575),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.menu_book_rounded,
                            color: Color(0xFF9E9E9E), size: 15),
                        const SizedBox(width: 5),
                        Text(
                          widget.petName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ── LIST ──
          Expanded(
            child: _filteredWords.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 4),
                    itemCount: _filteredWords.length,
                    itemBuilder: (context, index) {
                      final word = _filteredWords[index];
                      final isExpanded = _expandedIndex == index;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _expandedIndex = isExpanded ? null : index;
                              if (!isExpanded) _isPlaying = false;
                            });
                          },
                          child: isExpanded
                              ? _buildDetailedCard(word)
                              : _buildCollapsedCard(word),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // DETAILED CARD
  // ═══════════════════════════════════════════
  Widget _buildDetailedCard(VocabularyWord word) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD8E8EE), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Word + Badge ──
          Row(
            children: [
              Text(
                word.word,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(width: 8),
              if (word.isAccurate) _buildAccurateBadge(),
            ],
          ),
          const SizedBox(height: 6),

          // ── Translation ──
          Text(
            word.translation,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF616161),
              fontWeight: FontWeight.w500,
            ),
          ),

          // ── Example Usage Box ──
          if (word.example.isNotEmpty) ...[
            const SizedBox(height: 20),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      top: 22, left: 16, right: 16, bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: Text(
                    '${word.example}\n${word.exampleTranslation}',
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF424242),
                      height: 1.6,
                    ),
                  ),
                ),
                Positioned(
                  top: -9,
                  left: 14,
                  child: Container(
                    color: const Color(0xFFFAFAFA),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: const Text(
                      'Example Usage',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 20),

          // ── Audio Waveform Player ──
          _buildAudioPlayer(),

          const SizedBox(height: 18),

          // ── Added By Row ──
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Color(0xFF1EA3B8),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    word.addedByInitial,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Added by',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                  ),
                  Text(
                    word.addedBy,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── Info Note ──
          if (word.infoNote.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline,
                      color: Color(0xFF1976D2), size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      word.infoNote,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF1565C0),
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 24),

          // ── Community Verification ──
          _buildCommunityVerification(word),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // AUDIO PLAYER
  // ═══════════════════════════════════════════
  Widget _buildAudioPlayer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => _isPlaying = !_isPlaying),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFF89B29),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33F89B29),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _WaveformBars(isPlaying: _isPlaying),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // COMMUNITY VERIFICATION
  // ═══════════════════════════════════════════
  Widget _buildCommunityVerification(VocabularyWord word) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Community Verification',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Help verify if this word and pronunciation are accurate.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF757575),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            // ── Accurate Button ──
            _VerifyButton(
              icon: Icons.thumb_up_outlined,
              label: 'Accurate',
              count: word.accurateVotes,
              isActive: false,
              onTap: () {
                // TODO: submit accurate vote
              },
            ),
            const SizedBox(width: 10),
            // ── Needs Review Button ──
            _VerifyButton(
              icon: Icons.thumb_down_outlined,
              label: 'Needs Review',
              count: word.needsReviewVotes,
              isActive: false,
              onTap: () {
                // TODO: submit needs review vote
              },
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════
  // COLLAPSED CARD
  // ═══════════════════════════════════════════
  Widget _buildCollapsedCard(VocabularyWord word) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAEAEA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      word.word,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (word.isAccurate) _buildAccurateBadge(),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  word.translation,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF616161),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          _buildSpeakerIcon(word.word),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // ACCURATE BADGE
  // ═══════════════════════════════════════════
  Widget _buildAccurateBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1EA3B8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white, size: 11),
          SizedBox(width: 4),
          Text(
            'Accurate',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // SPEAKER ICON
  // ═══════════════════════════════════════════
  Widget _buildSpeakerIcon(String word) {
    return GestureDetector(
      onTap: () {
        // TODO: FlutterTts().speak(word)
      },
      child: Container(
        width: 38,
        height: 38,
        decoration: const BoxDecoration(
          color: Color(0xFFFFF3E0),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.volume_up_rounded,
          color: Color(0xFFF89B29),
          size: 20,
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════
  // FILTER CHIP
  // ═══════════════════════════════════════════
  Widget _buildChip(String text, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFBBE5FB) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : const Color(0xFFDEDEDE),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected
              ? const Color(0xFF003E5C)
              : const Color(0xFF4A4A4A),
          fontWeight:
              isSelected ? FontWeight.w800 : FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════
  // EMPTY STATE
  // ═══════════════════════════════════════════
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_rounded,
              size: 64, color: Color(0xFFB0BEC5)),
          const SizedBox(height: 16),
          const Text(
            'Kata tidak ditemukan',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF607D8B)),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba kata kunci lain',
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// WAVEFORM BARS WIDGET
// ═══════════════════════════════════════════
class _WaveformBars extends StatefulWidget {
  final bool isPlaying;

  const _WaveformBars({required this.isPlaying});

  @override
  State<_WaveformBars> createState() => _WaveformBarsState();
}

class _WaveformBarsState extends State<_WaveformBars>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<double> _barHeights = [
    8, 16, 28, 20, 36, 24, 40, 30, 38, 22,
    34, 18, 32, 26, 38, 20, 30, 14, 28, 36,
    22, 40, 18, 34, 24, 30, 16, 38, 26, 20,
    32, 14, 36, 22,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(_barHeights.length, (i) {
            double height = _barHeights[i];
            if (widget.isPlaying) {
              final offset = (i / _barHeights.length) * 2 * pi;
              final wave = sin(_controller.value * 2 * pi + offset);
              height =
                  (_barHeights[i] * (0.6 + 0.4 * ((wave + 1) / 2)))
                      .clamp(6.0, 44.0);
            }
            return Container(
              width: 3.5,
              height: height,
              decoration: BoxDecoration(
                color: const Color(0xFFF89B29),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════
// VERIFY BUTTON  ← compact pill, layout Row
// ═══════════════════════════════════════════
class _VerifyButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _VerifyButton({
    required this.icon,
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? const Color(0xFF00334E)
        : const Color(0xFF9E9E9E);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? const Color(0xFF42E0FF)
                : const Color(0xFFE0E0E0),
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              '$label ($count)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// HEADER WAVE CLIPPER
// ═══════════════════════════════════════════
class DictionaryHeaderClipper extends CustomClipper<Path> {
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
