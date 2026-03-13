import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── Background circle fill ──
  late AnimationController _bgController;
  late Animation<double> _bgRadius;

  // ── Mascot (Drop & Bounce) ──
  late AnimationController _mascotController;
  late Animation<double> _mascotY;
  late Animation<double> _mascotScale;

  // ── Shadow ──
  late AnimationController _shadowController;
  late Animation<double> _shadowScale;
  late Animation<double> _shadowOpacity;

  // ── Particles ──
  late AnimationController _particleController;
  late Animation<double> _particleProgress;

  // ── Text ──
  late AnimationController _textController;
  late Animation<double> _textOpacity;
  late Animation<double> _textSlideY;

  // ── Shimmer ──
  late AnimationController _shimmerController;
  late Animation<double> _shimmerX;

  // ── Text squeeze saat GIF mendarat ──
  late AnimationController _squeezeController;
  late Animation<double> _squeezeScale;

  bool _showParticles = false;
  final List<_Particle> _particles = List.generate(16, (i) => _Particle(i));

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _setupAnimations();
    _startSequence();
  }

  void _setupAnimations() {
    // ── BACKGROUND WIPE ──
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _bgRadius = Tween<double>(begin: 0.0, end: 1200.0).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeInOutCubic),
    );

    // ── MASCOT DROP & BOUNCE ──
    _mascotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    // Mulai dari sangat jauh di atas (-500) → turun ke posisi duduk di teks (0)
    _mascotY = Tween<double>(begin: -500.0, end: 0.0).animate(
      CurvedAnimation(parent: _mascotController, curve: Curves.elasticOut),
    );
    _mascotScale = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _mascotController, curve: Curves.elasticOut),
    );

    // ── SHADOW ──
    _shadowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _shadowScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shadowController, curve: Curves.elasticOut),
    );
    _shadowOpacity = Tween<double>(begin: 0.0, end: 0.3).animate(
      CurvedAnimation(
          parent: _shadowController, curve: const Interval(0.0, 0.5)),
    );

    // ── PARTICLES ──
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _particleProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _particleController, curve: Curves.easeOutCubic),
    );

    // ── TEXT ──
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );
    _textSlideY = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutBack),
    );

    // ── SQUEEZE (teks "ditekan" saat GIF mendarat) ──
    _squeezeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // Scale Y mengecil sedikit (efek tertekan) lalu balik normal
    _squeezeScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.88),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.88, end: 1.0),
        weight: 60,
      ),
    ]).animate(
      CurvedAnimation(parent: _squeezeController, curve: Curves.easeInOut),
    );

    // ── SHIMMER ──
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _shimmerX = Tween<double>(begin: -200.0, end: 400.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  void _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));

    // 1. Background wipe
    _bgController.forward();

    // 2. Text muncul duluan (target pijakan)
    await Future.delayed(const Duration(milliseconds: 350));
    _textController.forward();

    // 3. Mascot mulai jatuh setelah teks muncul
    await Future.delayed(const Duration(milliseconds: 200));
    _mascotController.forward();
    _shadowController.forward();

    // 4. Tepat saat GIF mendarat → squeeze teks + particles
    Future.delayed(const Duration(milliseconds: 550), () {
      if (mounted) {
        _squeezeController.forward(); // Teks tertekan
        setState(() => _showParticles = true);
        _particleController.forward();
      }
    });

    // 5. Shimmer
    await Future.delayed(const Duration(milliseconds: 800));
    _shimmerController.forward();

    // 6. Idle hold
    await Future.delayed(const Duration(milliseconds: 2500));

    // 7. Navigate
    if (mounted) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
      context.go('/welcome');
    }
  }

  @override
  void dispose() {
    _bgController.dispose();
    _mascotController.dispose();
    _shadowController.dispose();
    _particleController.dispose();
    _textController.dispose();
    _squeezeController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cx = size.width / 2;
    final cy = size.height / 2;

    return Scaffold(
      backgroundColor: const Color(0xFF38D1F5),
      body: Stack(
        children: [
          // ── LAYER 1: Background wipe ──
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, _) {
              return CustomPaint(
                size: size,
                painter: _SolidCirclePainter(
                  center: Offset(cx, cy),
                  radius: _bgRadius.value,
                  color: Colors.white,
                ),
              );
            },
          ),

          // ── LAYER 2: Komposisi utama (GIF di atas teks) ──
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── GIF Maskot (lebih besar, melompat dari atas) ──
                AnimatedBuilder(
                  animation: _mascotController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _mascotY.value),
                      child: Transform.scale(
                        scale: _mascotScale.value,
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset(
                    AppAssets.maskotLompat,
                    width: 260,   // ✅ Lebih besar
                    height: 260,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      width: 260,
                      height: 260,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE6F5FE),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.pets_rounded,
                        size: 120,
                        color: Color(0xFF38D1F5),
                      ),
                    ),
                  ),
                ),

                // ── Shadow tepat di bawah GIF ──
                AnimatedBuilder(
                  animation: _shadowController,
                  builder: (context, _) {
                    return Opacity(
                      opacity: _shadowOpacity.value,
                      child: Transform.scale(
                        scaleX: _shadowScale.value,
                        scaleY: 0.25,
                        child: Container(
                          width: 140,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 12,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // ── Jarak negatif: teks "dinjak" GIF ──
                const SizedBox(height: 1),

                // ── Teks LinguPet (muncul duluan, lalu "ditekan") ──
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _textController,
                    _shimmerController,
                    _squeezeController,
                  ]),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textOpacity.value,
                      child: Transform.translate(
                        offset: Offset(0, _textSlideY.value),
                        // ✅ Efek squeeze saat GIF mendarat
                        child: Transform.scale(
                          scaleY: _squeezeScale.value,
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                colors: const [
                                  Color(0xFF1A1A2E),
                                  Color(0xFF38D1F5),
                                  Colors.white,
                                  Color(0xFF38D1F5),
                                  Color(0xFF1A1A2E),
                                ],
                                stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                                begin: Alignment(
                                  (_shimmerX.value / bounds.width) * 2 - 1,
                                  0,
                                ),
                                end: Alignment(
                                  (_shimmerX.value / bounds.width) * 2 + 1,
                                  0,
                                ),
                              ).createShader(bounds);
                            },
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Lingu',
                                    style: TextStyle(
                                      fontSize: 46,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF1A1A2E),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  // ✅ 
                                  TextSpan(
                                    text: 'Pet',
                                    style: TextStyle(
                                      fontSize: 46,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF38D1F5),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // ── LAYER 3: Particles (meledak dari titik pendaratan) ──
          if (_showParticles)
            AnimatedBuilder(
              animation: _particleController,
              builder: (context, _) {
                return CustomPaint(
                  size: size,
                  painter: _ParticlePainter(
                    particles: _particles,
                    progress: _particleProgress.value,
                    center: Offset(cx, cy + 10),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// PAINTERS & HELPERS
// ═══════════════════════════════════════════
class _SolidCirclePainter extends CustomPainter {
  final Offset center;
  final double radius;
  final Color color;

  _SolidCirclePainter({
    required this.center,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_SolidCirclePainter old) =>
      old.radius != radius || old.color != color;
}

class _Particle {
  final double angle;
  final double speed;
  final double size;
  final Color color;

  _Particle(int index)
      : angle = (index / 16) * 2 * pi + Random().nextDouble() * 0.4,
        speed = 60 + Random().nextDouble() * 120,
        size = 4 + Random().nextDouble() * 8,
        color = [
          const Color(0xFF38D1F5),
          const Color(0xFF0BBCE0),
          const Color(0xFFFFD700),
          const Color(0xFFFF6B6B),
          const Color(0xFF7C4DFF),
          const Color(0xFF00E676),
        ][index % 6];
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Offset center;

  _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.center,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final dist = p.speed * progress;
      final x = center.dx + cos(p.angle) * dist;
      final y = center.dy + sin(p.angle) * dist;
      final opacity = (1.0 - progress).clamp(0.0, 1.0);

      canvas.drawCircle(
        Offset(x, y),
        p.size * (1 - progress * 0.5),
        Paint()
          ..color = p.color.withOpacity(opacity)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}
