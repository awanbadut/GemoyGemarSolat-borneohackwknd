import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingupet/core/constants/app_assets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {

  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _contentController;
  late Animation<double> _contentFade;
  late Animation<double> _contentSlide;

  final List<_OnboardData> _pages = const [
    _OnboardData(
      image: AppAssets.onboard3, // slide 1: Explore regional languages
      title: 'Explore regional languages',
      subtitle:
          'Journey through the heart of\nSoutheast Asia and master the\nlanguages of your ancestors.',
    ),
    _OnboardData(
      image: AppAssets.onboard2, // slide 2: Make Learning More Exciting
      title: 'Make Learning More Exciting',
      subtitle:
          'Enjoy game-like lessons that feel like\nplay! Earn rewards and unlock new\nlevels while mastering regional dialects.',
    ),
    _OnboardData(
      image: AppAssets.onboard1, // slide 3: Meet Your Pet
      title: 'Meet Your Pet',
      subtitle:
          'Level up and collect unique guardians\nas you learn',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _contentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeIn),
    );
    _contentSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );
    _contentController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    _contentController.reset();
    _contentController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6FB),
      body: SafeArea(
        child: Column(
          children: [

            // ── TOP BAR ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Lingu',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        TextSpan(
                          text: 'Pet',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF38D1F5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.star_border_rounded,
                    color: Color(0xFF38D1F5),
                    size: 26,
                  ),
                ],
              ),
            ),

            // Subtitle tetap
            const Text(
              'Master Native Tongues',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF7A8FA6),
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            // ── PAGE VIEW (gambar) ──
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset(
                      _pages[index].image,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),

            // ── BOTTOM CARD ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 20,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Title + subtitle dengan animasi
                  AnimatedBuilder(
                    animation: _contentController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _contentFade.value,
                        child: Transform.translate(
                          offset: Offset(0, _contentSlide.value),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          _pages[_currentPage].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _pages[_currentPage].subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7A8FA6),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── DOT INDICATOR ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      final isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFFF5A623)
                              : const Color(0xFFDDE3EA),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 24),

                  // ── BUTTON ──
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5A623),
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor:
                            const Color(0xFFF5A623).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? "Let's Get Started"
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
}

class _OnboardData {
  final String image;
  final String title;
  final String subtitle;
  const _OnboardData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
