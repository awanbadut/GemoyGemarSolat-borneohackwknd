import 'package:flutter/material.dart';
import 'package:lingupet/features/learn/screens/module_start_screen.dart';

// ═══════════════════════════════════════════
// DATA MODEL TOPIC
// ═══════════════════════════════════════════
class TopicStep {
  final int number;
  final String label;
  const TopicStep({required this.number, required this.label});
}

class TopicData {
  final String title;
  final int stepCount;
  final List<TopicStep> steps;
  const TopicData(
      {required this.title,
      required this.stepCount,
      required this.steps});
}

// ═══════════════════════════════════════════
// MODULE DETAIL SCREEN
// ═══════════════════════════════════════════
class ModuleDetailScreen extends StatefulWidget {
  final String moduleName;
  final String flag;
  final String region;
  final String petAsset;
  final Color bgColor;
  final double percent;

  const ModuleDetailScreen({
    super.key,
    required this.moduleName,
    required this.flag,
    required this.region,
    required this.petAsset,
    required this.bgColor,
    this.percent = 0.45,
  });

  @override
  State<ModuleDetailScreen> createState() => _ModuleDetailScreenState();
}

class _ModuleDetailScreenState extends State<ModuleDetailScreen> {
  final Set<int> _expandedTopics = {0};

  final List<TopicData> _topics = const [
    TopicData(
      title: 'Topic 1:  facilisi tellus at blandit. Ac',
      stepCount: 5,
      steps: [
        TopicStep(number: 1, label: 'The\nIcebreaker'),
        TopicStep(number: 2, label: 'Chatter\nBox'),
        TopicStep(number: 3, label: 'The Polite\nGuest'),
        TopicStep(number: 4, label: 'Respect\nHero'),
        TopicStep(number: 5, label: 'Native\nSoul'),
      ],
    ),
    TopicData(
      title: 'Topic 2 : Sollicitudin pellentesque',
      stepCount: 5,
      steps: [],
    ),
    TopicData(
      title: 'Topic 3 : Vulputate ultrices quisque',
      stepCount: 5,
      steps: [],
    ),
    TopicData(
      title: 'Topic 4: ut maecenas accumsan.',
      stepCount: 5,
      steps: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── SCROLLABLE CONTENT ──
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(context),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── DESKRIPSI ──
                      const Text('Deskripsi',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A1A2E))),
                      const SizedBox(height: 8),
                      const Text(
                        'Tincidunt id nisi consequat orci interdum sit. Nisl aliquam felis pellentesque cursus nec urna a ut. Lobortis arcu cursus amet feugiat dictum vel penatibus justo aliquam. Pellentesque orci ultrices id orci vulputate volutpat. Justo velit dictum eget vulputate tortor molestie pretium eget velit. Neque orci sed magna nisl at nunc eget.',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF4A5568),
                            height: 1.6),
                      ),
                      const SizedBox(height: 20),

                      // ── TOPIC LIST ──
                      ..._topics.asMap().entries.map((e) {
                        final idx = e.key;
                        final topic = e.value;
                        return _TopicAccordion(
                          topic: topic,
                          isExpanded: _expandedTopics.contains(idx),
                          onToggle: () => setState(() {
                            _expandedTopics.contains(idx)
                                ? _expandedTopics.remove(idx)
                                : _expandedTopics.add(idx);
                          }),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── BOTTOM BUTTON — fixed ──
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0x15000000),
                      blurRadius: 12,
                      offset: Offset(0, -3)),
                ],
              ),
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ModuleStartScreen(
                        moduleName: widget.moduleName,
                        flag: widget.flag,
                        region: widget.region,
                        petAsset: widget.petAsset,
                        bgColor: widget.bgColor,
                        percent: widget.percent,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5A623),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    "Let's Get Started",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── HERO SECTION ──
  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFB8E4F5),
            const Color(0xFFE8F6FB).withOpacity(0.3),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Wave putih bawah hero
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: CustomPaint(
              size: const Size(double.infinity, 40),
              painter: _WavePainter(),
            ),
          ),

          // Close button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close_rounded,
                    size: 18, color: Color(0xFF1A1A2E)),
              ),
            ),
          ),

          // Center content
          Padding(
            padding: EdgeInsets.fromLTRB(
                16, MediaQuery.of(context).padding.top + 16, 16, 40),
            child: Column(
              children: [
                Text(
                  widget.moduleName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E)),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.flag,
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Text(widget.region,
                        style: const TextStyle(
                            fontSize: 13, color: Color(0xFF4A5568))),
                  ],
                ),
                const SizedBox(height: 12),
                Image.asset(
                  widget.petAsset,
                  height: 180,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const SizedBox(height: 180),
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
// WAVE PAINTER
// ═══════════════════════════════════════════
class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.25, 0, size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.8, size.width, 0);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_WavePainter _) => false;
}

// ═══════════════════════════════════════════
// TOPIC ACCORDION
// ═══════════════════════════════════════════
class _TopicAccordion extends StatelessWidget {
  final TopicData topic;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _TopicAccordion(
      {required this.topic,
      required this.isExpanded,
      required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Row(
                children: [
                  Container(
                    width: 34, height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A5298).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.menu_book_rounded,
                        size: 18, color: Color(0xFF2A5298)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(topic.title,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E))),
                        const SizedBox(height: 2),
                        Text('${topic.stepCount} Steps to level up',
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
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          // ── STEPS (expanded) ──
          if (isExpanded && topic.steps.isNotEmpty) ...[
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: _StepTimeline(steps: topic.steps),
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// STEP TIMELINE
// ═══════════════════════════════════════════
class _StepTimeline extends StatelessWidget {
  final List<TopicStep> steps;
  const _StepTimeline({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.asMap().entries.expand((e) {
        final i = e.key;
        final step = e.value;
        final isLast = i == steps.length - 1;
        return [
          _StepNode(step: step),
          if (!isLast)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 13),
                child: CustomPaint(
                  size: const Size(double.infinity, 2),
                  painter: _DashedLinePainter(),
                ),
              ),
            ),
        ];
      }).toList(),
    );
  }
}

class _StepNode extends StatelessWidget {
  final TopicStep step;
  const _StepNode({required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFF38D1F5).withOpacity(0.15),
            shape: BoxShape.circle,
            border:
                Border.all(color: const Color(0xFF38D1F5), width: 1.5),
          ),
          child: Center(
            child: Text('${step.number}',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF38D1F5))),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          step.label,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 9, color: Color(0xFF4A5568), height: 1.3),
        ),
      ],
    );
  }
}

// ─── Dashed line painter ───
class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF38D1F5)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 5.0;
    const dashSpace = 4.0;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter _) => false;
}
