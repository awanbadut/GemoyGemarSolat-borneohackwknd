import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingupet/core/constants/app_assets.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {

  late AnimationController _fadeController;
  late Animation<double> _fadeIn;
  late Animation<double> _slideY;

  late AnimationController _buttonController;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideY = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _buttonScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.elasticOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6FB), // biru muda
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _fadeController,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeIn.value,
              child: Transform.translate(
                offset: Offset(0, _slideY.value),
                child: child,
              ),
            );
          },
          child: Column(
            children: [

              // ── TOP BAR ──
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo LinguPet
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

                    // Bookmark icon (bintang outline)
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.star_border_rounded,
                        color: Color(0xFF38D1F5),
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),

              // Subtitle
              const Text(
                'Master Native Tongues',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF7A8FA6),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),

              const SizedBox(height: 16),

              // ── MASCOT IMAGE (full asset welcome.png) ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(
                    AppAssets.welcome,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // ── BOTTOM SECTION ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
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

                    // Judul
                    const Text(
                      'Start Your Adventure!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Deskripsi
                    const Text(
                      'Discover the magic of Southeast\nAsian languages with your Guardian.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7A8FA6),
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── 3 FEATURE ICONS ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _FeatureIcon(
                            icon: Icons.celebration_rounded,
                            label: 'Fun'),
                        SizedBox(width: 32),
                        _FeatureIcon(
                            icon: Icons.account_balance_rounded,
                            label: 'Culture'),
                        SizedBox(width: 32),
                        _FeatureIcon(
                            icon: Icons.auto_awesome_rounded,
                            label: 'Heritage'),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ── BUTTON "Let's Get Started" ──
                    AnimatedBuilder(
                      animation: _buttonController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _buttonScale.value,
                          child: child,
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => context.go('/onboarding'),
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
                          child: const Text(
                            "Let's Get Started",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
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
      ),
    );
  }
}

// ── FEATURE ICON WIDGET ──
class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFE8F0F7),
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: const Color(0xFFF5A623),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}
