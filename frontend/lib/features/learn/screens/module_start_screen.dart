import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'package:lingupet/features/learn/screens/lesson_screen.dart';

// ═══════════════════════════════════════════
// MODULE START SCREEN
// ═══════════════════════════════════════════
class ModuleStartScreen extends StatefulWidget {
  final String moduleName;
  final String flag;
  final String region;
  final String petAsset;
  final Color bgColor;
  final double percent;

  const ModuleStartScreen({
    super.key,
    required this.moduleName,
    required this.flag,
    required this.region,
    required this.petAsset,
    required this.bgColor,
    required this.percent,
  });

  @override
  State<ModuleStartScreen> createState() => _ModuleStartScreenState();
}

class _ModuleStartScreenState extends State<ModuleStartScreen> {
  // Melacak status expand/collapse tiap topik (Index 0 adalah Topic 1)
  final List<bool> _expandedTopics = [true, false, false, false];

  void _toggleTopic(int index) {
    setState(() {
      _expandedTopics[index] = !_expandedTopics[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          // ── BACKGROUND WAVE HEADER ──
          ClipPath(
            clipper: _HeaderWaveClipper(),
            child: Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF42E0FF), Color(0xFFE8F6FB), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          // ── MAIN SCROLLABLE CONTENT ──
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: 16),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        // COURSE PROGRESS
                        _CourseProgressCard(
                          petAsset: widget.petAsset,
                          percent: widget.percent,
                        ),
                        const SizedBox(height: 24),

                        // TOPIC 1 (Active)
                        _TopicAccordion(
                          title: 'Topic 1: facilisi tellus at blandit. Ac',
                          stepCount: 5,
                          isLocked: false,
                          isExpanded: _expandedTopics[0],
                          onToggle: () => _toggleTopic(0),
                          onStartLesson: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => LessonScreen(petAsset: widget.petAsset),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // TOPIC 2 (Locked)
                        _TopicAccordion(
                          title: 'Topic 2 : Sollicitudin pellentesque',
                          stepCount: 5,
                          isLocked: true,
                          isExpanded: _expandedTopics[1],
                          onToggle: () => _toggleTopic(1),
                        ),
                        const SizedBox(height: 12),

                        // TOPIC 3 (Locked)
                        _TopicAccordion(
                          title: 'Topic 3 : Vulputate ultrices quisque',
                          stepCount: 5,
                          isLocked: true,
                          isExpanded: _expandedTopics[2],
                          onToggle: () => _toggleTopic(2),
                        ),
                        const SizedBox(height: 12),

                        // TOPIC 4 (Locked)
                        _TopicAccordion(
                          title: 'Topic 4: ut maecenas accumsan.',
                          stepCount: 5,
                          isLocked: true,
                          isExpanded: _expandedTopics[3],
                          onToggle: () => _toggleTopic(3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF05354C)),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                widget.moduleName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF05354C),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.flag, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(
                    widget.region,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05354C),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// COURSE PROGRESS CARD
// ═══════════════════════════════════════════
class _CourseProgressCard extends StatelessWidget {
  final String petAsset;
  final double percent;

  const _CourseProgressCard({required this.petAsset, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Pet Image with Glow Background
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFF6ED),
              border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
            ),
            child: ClipOval(
              child: Image.asset(
                petAsset,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                    Icons.pets_rounded,
                    size: 36,
                    color: Color(0xFFB0BEC5)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Course Progress',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF05354C))),
                    Text('${(percent * 100).toInt()}%',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFF89B29))),
                  ],
                ),
                const SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: percent,
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF89B29),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
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
// TOPIC ACCORDION (Expandable for both Active and Locked)
// ═══════════════════════════════════════════
class _TopicAccordion extends StatelessWidget {
  final String title;
  final int stepCount;
  final bool isLocked;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback? onStartLesson;

  const _TopicAccordion({
    required this.title,
    required this.stepCount,
    required this.isLocked,
    required this.isExpanded,
    required this.onToggle,
    this.onStartLesson,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isExpanded 
        ? (isLocked ? Colors.white : const Color(0xFFF2FBFD)) // Terkunci putih, aktif cyan muda
        : Colors.white;
    final headerColor = isLocked ? Colors.white : const Color(0xFFE5F8FA);
    final iconColor = isLocked ? const Color(0xFF94A3B8) : const Color(0xFF004D73);
    final iconBgColor = isLocked ? const Color(0xFFF1F5F9) : Colors.white;
    final iconData = isLocked ? Icons.lock_rounded : Icons.menu_book_rounded;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: isExpanded && !isLocked ? Border.all(color: const Color(0xFFD6F1F8)) : Border.all(color: Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── HEADER ──
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: isExpanded 
                    ? const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                    : BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(iconData, size: 18, color: iconColor),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: isLocked ? const Color(0xFF4A5568) : const Color(0xFF05354C),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$stepCount Steps to level up',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isLocked ? const Color(0xFF94A3B8) : const Color(0xFF38D1F5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── ZIGZAG PATH BODY (Hanya muncul jika expanded) ──
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: _ZigzagPath(
                isLocked: isLocked,
                onStartLesson: onStartLesson,
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// ZIGZAG PATH (Dinamis: Active / Locked)
// ═══════════════════════════════════════════
class _ZigzagPath extends StatelessWidget {
  final bool isLocked;
  final VoidCallback? onStartLesson;

  const _ZigzagPath({required this.isLocked, this.onStartLesson});

  @override
  Widget build(BuildContext context) {
    // Definisi Nodes (5 langkah)
    final nodes = isLocked
        ? [
            const _NodeData(status: 'locked', xFrac: 0.6, label: 'Intro', showStar: false),
            const _NodeData(status: 'locked', xFrac: 0.2, label: '', showStar: false),
            const _NodeData(status: 'locked', xFrac: 0.6, label: '', showStar: false),
            const _NodeData(status: 'locked', xFrac: 0.2, label: '', showStar: false),
            const _NodeData(status: 'gift_locked', xFrac: 0.5, label: '', showStar: false),
          ]
        : [
            const _NodeData(status: 'done', xFrac: 0.6, label: 'Intro', showStar: true),
            const _NodeData(status: 'active', xFrac: 0.2, label: '', showStar: false),
            const _NodeData(status: 'active', xFrac: 0.6, label: '', showStar: false, showStart: true),
            const _NodeData(status: 'locked', xFrac: 0.2, label: '', showStar: false),
            const _NodeData(status: 'gift_locked', xFrac: 0.5, label: '', showStar: false),
          ];

    final w = MediaQuery.of(context).size.width - 48; // Lebar relatif terhadap layar
    const double nodeSize = 56.0;
    const double rowH = 80.0; // Jarak vertikal antar node

    return SizedBox(
      height: rowH * nodes.length - 20, // Total tinggi area zigzag
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // GARIS PUTUS-PUTUS PENGHUBUNG
          Positioned.fill(
            child: CustomPaint(
              painter: _ZigzagPainter(
                nodes: nodes,
                rowH: rowH,
                nodeSize: nodeSize,
                totalWidth: w,
              ),
            ),
          ),
          // NODES
          ...nodes.asMap().entries.map((e) {
            final i = e.key;
            final node = e.value;
            return Positioned(
              top: i * rowH,
              left: node.xFrac * w - (nodeSize / 2),
              child: _NodeWidget(
                node: node,
                size: nodeSize,
                number: i + 1,
                onStart: node.showStart ? onStartLesson : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// DATA STRUKTUR NODE
// ═══════════════════════════════════════════
class _NodeData {
  final String status; // 'done', 'active', 'locked', 'gift_locked'
  final double xFrac;
  final String label;
  final bool showStar;
  final bool showStart;

  const _NodeData({
    required this.status,
    required this.xFrac,
    required this.label,
    required this.showStar,
    this.showStart = false,
  });
}

// ═══════════════════════════════════════════
// WIDGET SATUAN NODE
// ═══════════════════════════════════════════
class _NodeWidget extends StatelessWidget {
  final _NodeData node;
  final double size;
  final int number;
  final VoidCallback? onStart;

  const _NodeWidget({
    required this.node,
    required this.size,
    required this.number,
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    Widget inner;

    switch (node.status) {
      case 'done':
        inner = Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Color(0xFF1EA36D),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 28),
        );
        break;
      case 'active':
        inner = Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Color(0xFF1EA36D),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text('$number',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),
          ),
        );
        break;
      case 'gift_locked':
        inner = Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Color(0xFFF1F5F9), // Light grey
            shape: BoxShape.circle,
          ),
          child: const Center(child: Icon(Icons.card_giftcard_rounded, color: Color(0xFF8E24AA), size: 26)),
        );
        break;
      default: // 'locked'
        inner = Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Color(0xFFE2E8F0), // Grey circle
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text('$number',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),
          ),
        );
    }

    return SizedBox(
      width: size + 80, // Extra width to allow overlapping elements like Star/Start btn
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Core Circle
          inner,

          // Star Badge
          if (node.showStar)
            Positioned(
              top: -6,
              left: size - 14,
              child: const Text('⭐', style: TextStyle(fontSize: 18)),
            ),

          // Label text below node
          if (node.label.isNotEmpty)
            Positioned(
              top: size + 8,
              left: -10,
              width: size + 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)
                  ]
                ),
                child: Text(
                  node.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Start Button Hover
          if (node.showStart)
            Positioned(
              top: -10,
              left: size + 16,
              child: GestureDetector(
                onTap: onStart,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Light orange glow background
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDEBCC),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Inner solid orange play button
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF89B29),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30),
                    ),
                    // Start Label Pill
                    Positioned(
                      bottom: -8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF89B29),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          'Start',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// ZIGZAG PAINTER (Garis Putus-Putus / Dashed)
// ═══════════════════════════════════════════
class _ZigzagPainter extends CustomPainter {
  final List<_NodeData> nodes;
  final double rowH;
  final double nodeSize;
  final double totalWidth;

  const _ZigzagPainter({
    required this.nodes,
    required this.rowH,
    required this.nodeSize,
    required this.totalWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintGreen = Paint()
      ..color = const Color(0xFF1EA36D)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintGrey = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < nodes.length - 1; i++) {
      final curr = nodes[i];
      final next = nodes[i + 1];

      final x1 = curr.xFrac * totalWidth;
      final y1 = i * rowH + (nodeSize / 2);
      final x2 = next.xFrac * totalWidth;
      final y2 = (i + 1) * rowH + (nodeSize / 2);

      final path = Path()
        ..moveTo(x1, y1)
        ..cubicTo(
          x1, y1 + (y2 - y1) * 0.4,
          x2, y2 - (y2 - y1) * 0.4,
          x2, y2,
        );

      // Logika warna path: Jika node tujuan (next) active/done, maka jalurnya hijau. Selain itu abu-abu.
      final isGreenPath = next.status == 'done' || next.status == 'active';
      final selectedPaint = isGreenPath ? paintGreen : paintGrey;

      _drawDashedPath(canvas, path, selectedPaint);
    }
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double start = 0;
      const dashLen = 10.0;
      const gapLen = 8.0;
      while (start < metric.length) {
        final end = math.min(start + dashLen, metric.length);
        canvas.drawPath(metric.extractPath(start, end), paint);
        start += dashLen + gapLen;
      }
    }
  }

  @override
  bool shouldRepaint(_ZigzagPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════
// CLIPPER: HEADER WAVE
// ═══════════════════════════════════════════
class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width * 0.25, size.height + 10, size.width * 0.5, size.height - 15);
    path.quadraticBezierTo(size.width * 0.75, size.height - 40, size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}