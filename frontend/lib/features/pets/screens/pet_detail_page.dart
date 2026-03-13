import 'package:flutter/material.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/features/pets/screens/build_vocabulary_page.dart';
import 'package:lingupet/features/pets/screens/language_dictionary_page.dart';
import 'package:lingupet/features/pets/screens/pet_list_page.dart';

// ═══════════════════════════════════════════
// MODEL
// ═══════════════════════════════════════════
class PetDetailData {
  final String name;
  final String region;
  final String flag;
  final String bgAsset;
  final String language;
  final int level;
  final double progress;
  final int vocabularyCount;
  final int audioCount;
  final int contributorCount;
  final String stageName;
  final String stageDescription;
  final int nextLevelRequired;
  final int nextVocabRequired;
  final int nextAudioRequired;
  final String accent;

  const PetDetailData({
    required this.name,
    required this.region,
    required this.flag,
    required this.bgAsset,
    required this.language,
    required this.level,
    required this.progress,
    required this.vocabularyCount,
    required this.audioCount,
    required this.contributorCount,
    required this.stageName,
    required this.stageDescription,
    required this.nextLevelRequired,
    required this.nextVocabRequired,
    required this.nextAudioRequired,
    required this.accent,
  });
}

// ═══════════════════════════════════════════
// PET DETAIL PAGE
// ═══════════════════════════════════════════
class PetDetailPage extends StatelessWidget {
  final PetDetailData data;

  const PetDetailPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ── App Bar ──
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE6F5FE),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Color(0xFF00334E), size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PetListPage()),
                      ),

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6F5FE),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add_circle,
                                color: Color(0xFF00334E), size: 18),
                            SizedBox(width: 6),
                            Text(
                              'New Pet',
                              style: TextStyle(
                                color: Color(0xFF00334E),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Profile Card ──
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              padding: const EdgeInsets.only(
                  top: 24, bottom: 32, left: 24, right: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Pet Avatar
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFE0B2).withOpacity(0.6),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(data.bgAsset),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8F2FF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            'Lvl. ${data.level}',
                            style: const TextStyle(
                              color: Color(0xFF1EA3B8),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Name
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${data.flag} ',
                          style: const TextStyle(fontSize: 14)),
                      Text(
                        data.region,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF616161),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Status Pill
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1EA3B8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${data.stageName} – Level ${data.level}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Accent description
                  Text(
                    data.accent,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Progress Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Next Level Progress',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${(data.progress * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1EA3B8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: data.progress,
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1EA3B8),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Stats Row ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      Icons.article_outlined,
                      const Color(0xFF1976D2),
                      '${data.vocabularyCount}',
                      'Vocabulary',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      Icons.volume_up_outlined,
                      const Color(0xFF388E3C),
                      '${data.audioCount}',
                      'Audio',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      Icons.group_outlined,
                      const Color(0xFF7B1FA2),
                      '${data.contributorCount}',
                      'Contributor',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Quick Feed Button → BuildVocabularyPage ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BuildVocabularyPage(),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF59B2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Quick Feed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ── Latest Vocabulary Card ──
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEAEAEA)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest Vocabulary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      // See All → LanguageDictionaryPage
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LanguageDictionaryPage(
                              petName: data.name,
                              languageName: data.language,
                            ),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1976D2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Dummy latest vocab — nanti ganti dari API/provider
                  _buildVocabItem(
                      'Sila',
                      'Please',
                      '"',
                      'Sila',
                      ' singgah, indak ado nan malarang doh."',
                      'Budi Santoso',
                      '234'),
                  const SizedBox(height: 16),
                  _buildVocabItem('Ambo', "I'm", '"Iyo, beko ', 'ambo',
                      ' ka sinan."', 'Budi Ratush', '189'),
                  const SizedBox(height: 16),
                  _buildVocabItem('Baa', 'How', '"', 'Baa',
                      ' kaba sanak hari ko?"', 'Joko Widodo', '156'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Stage Card ──
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF05354C),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stage: ${data.stageName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    data.stageDescription,
                    style: const TextStyle(
                      color: Color(0xFFE0E0E0),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF315B70),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('🎯', style: TextStyle(fontSize: 14)),
                            SizedBox(width: 8),
                            Text(
                              'To reach the next stage:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildBulletPoint(
                            'Minimum level: ${data.nextLevelRequired}'),
                        const SizedBox(height: 8),
                        _buildBulletPoint(
                            'Vocabulary: +${data.nextVocabRequired} words'),
                        const SizedBox(height: 8),
                        _buildBulletPoint(
                            'Recorded audio: +${data.nextAudioRequired}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      IconData icon, Color iconColor, String number, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            number,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF757575),
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildVocabItem(
    String word,
    String translation,
    String exStart,
    String exBold,
    String exEnd,
    String author,
    String likes,
  ) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Color(0xFFF59B2A), width: 3.0)),
      ),
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(word,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                const SizedBox(height: 4),
                Text(translation,
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xFF616161))),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
                    children: [
                      TextSpan(text: exStart),
                      TextSpan(
                          text: exBold,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF757575))),
                      TextSpan(text: exEnd),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text('By: $author',
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFFBDBDBD))),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.favorite, color: Color(0xFFEF5350), size: 16),
              const SizedBox(width: 4),
              Text(likes,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFEF5350),
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          width: 4,
          height: 4,
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }
}
