import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:lingupet/core/constants/app_assets.dart';

// ═══════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════
class LessonScreen extends StatefulWidget {
  final String petAsset;
  const LessonScreen({super.key, required this.petAsset});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _taskIndex = 0;
  int _lives = 5;
  bool _showComplete = false;

  void _onTaskComplete() {
    if (_taskIndex < 2) {
      setState(() => _taskIndex++);
    } else {
      setState(() => _showComplete = true);
    }
  }

  void _onWrongAnswer() {
    setState(() {
      if (_lives > 0) _lives--;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showComplete) {
      return _LessonCompleteScreen(
        petAsset: widget.petAsset,
        onContinue: () => Navigator.of(context).pop(),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            ClipPath(
              clipper: _HeaderWaveClipper(),
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF42E0FF), Color(0xFFE8F6FB), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  _TopBar(
                    progress: (_taskIndex + 1) / 3.0,
                    lives: _lives,
                    onClose: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: _taskIndex == 0
                          ? _Task1Translate(
                              key: const ValueKey('task1'),
                              petAsset: widget.petAsset,
                              onComplete: _onTaskComplete,
                              onWrong: _onWrongAnswer,
                            )
                          : _taskIndex == 1
                              ? _Task2SelectImage(
                                  key: const ValueKey('task2'),
                                  petAsset: widget.petAsset,
                                  onComplete: _onTaskComplete,
                                  onWrong: _onWrongAnswer,
                                )
                              : _Task3PairWords(
                                  key: const ValueKey('task3'),
                                  onComplete: _onTaskComplete,
                                  onWrong: _onWrongAnswer,
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

// ═══════════════════════════════════════════
// TOP BAR
// ═══════════════════════════════════════════
class _TopBar extends StatelessWidget {
  final double progress;
  final int lives;
  final VoidCallback onClose;

  const _TopBar({
    required this.progress,
    required this.lives,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.close_rounded,
                  size: 20, color: Color(0xFF05354C)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF0BA360), Color(0xFF3CBA92)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              const Icon(Icons.favorite_rounded,
                  color: Color(0xFFE23D3D), size: 24),
              const SizedBox(width: 6),
              Text(
                '$lives',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TASK 1 — Translate Sentence
// ═══════════════════════════════════════════
class _Task1Translate extends StatefulWidget {
  final String petAsset;
  final VoidCallback onComplete;
  final VoidCallback onWrong;

  const _Task1Translate({
    super.key,
    required this.petAsset,
    required this.onComplete,
    required this.onWrong,
  });

  @override
  State<_Task1Translate> createState() => _Task1TranslateState();
}

class _Task1TranslateState extends State<_Task1Translate> {
  static const correctAnswer = ['I', 'am', 'Hungry'];

  final List<String> wordBank = ['I', 'you', 'Hungry', 'Happy', 'am', 'Sad'];
  final List<String> dropped = [];
  bool? checked;

  void tapWord(String word) {
    if (checked != null) return;
    setState(() => dropped.add(word));
  }

  void removeWord(int idx) {
    if (checked != null) return;
    setState(() => dropped.removeAt(idx));
  }

  void check() {
    if (dropped.isEmpty) return;
    final isCorrect = dropped.length == correctAnswer.length &&
        List.generate(dropped.length, (i) => dropped[i] == correctAnswer[i])
            .every((e) => e);
    setState(() => checked = isCorrect);
    if (!isCorrect) widget.onWrong();
  }

  void next() {
    if (checked == true) {
      widget.onComplete();
    } else {
      setState(() {
        checked = null;
        dropped.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final droppedCopy = List<String>.from(dropped);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Translate This Sentence',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 24),

                _QuestionCard(
                  petAsset: widget.petAsset,
                  word: 'Ambo Lapa',
                ),

                const SizedBox(height: 24),

                // ── DROP ZONE ──
                CustomPaint(
                  painter: _DashedRectPainter(),
                  child: Container(
                    width: double.infinity,
                    height: 72,
                    // ✅ center: "Tap words below" di tengah
                    alignment: Alignment.center,
                    child: dropped.isEmpty
                        ? const Text(
                            'Tap words below',
                            style: TextStyle(
                              color: Color(0xFF757575),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        // ✅ kata muncul ke samping dengan scroll horizontal
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: dropped
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: GestureDetector(
                                        onTap: () => removeWord(e.key),
                                        child: _WordPill(
                                          word: e.value,
                                          isSelected: true,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 32),

                // ── WORD BANK — Grid 3 kolom ──
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: wordBank.length,
                  itemBuilder: (_, idx) {
                    final w = wordBank[idx];
                    final tempCopy = List<String>.from(droppedCopy);
                    final isUsed = tempCopy.remove(w);
                    return GestureDetector(
                      onTap: isUsed ? null : () => tapWord(w),
                      child: Opacity(
                        opacity: isUsed ? 0.3 : 1.0,
                        child: _WordPill(word: w, isSelected: false),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        _BottomActionArea(
          enabled: dropped.isNotEmpty,
          checked: checked,
          onCheck: check,
          onNext: next,
          rightAnswer: 'I am Hungry',
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════
// TASK 2 — Select Image
// ═══════════════════════════════════════════
class _Task2SelectImage extends StatefulWidget {
  final String petAsset;
  final VoidCallback onComplete;
  final VoidCallback onWrong;

  const _Task2SelectImage({
    super.key,
    required this.petAsset,
    required this.onComplete,
    required this.onWrong,
  });

  @override
  State<_Task2SelectImage> createState() => _Task2SelectImageState();
}

class _Task2SelectImageState extends State<_Task2SelectImage> {
  int? _selected;
  bool? _checked;

  static const _options = [
    {'emoji': '🍽️', 'label': 'Plate'},
    {'emoji': '👨‍🍳', 'label': 'Kitchen'},
    {'emoji': '🏠', 'label': 'Home'},
    {'emoji': '☕', 'label': 'Cofee'},
  ];
  static const _correctIndex = 1;

  void _check() {
    if (_selected == null) return;
    final isCorrect = _selected == _correctIndex;
    setState(() => _checked = isCorrect);
    if (!isCorrect) widget.onWrong();
  }

  void _next() {
    if (_checked == true) {
      widget.onComplete();
    } else {
      setState(() {
        _checked = null;
        _selected = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select the correct image',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                _QuestionCard(petAsset: widget.petAsset, word: 'Dapua'),
                const SizedBox(height: 32),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: _options.length,
                  itemBuilder: (_, i) {
                    final opt = _options[i];
                    final isSelected = _selected == i;
                    return GestureDetector(
                      onTap: _checked != null
                          ? null
                          : () => setState(() => _selected = i),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF00334E)
                                : const Color(0xFFE0E0E0),
                            width: isSelected ? 2.5 : 1.5,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color:
                                    const Color(0xFF00334E).withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(opt['emoji']!,
                                style: const TextStyle(fontSize: 48)),
                            const SizedBox(height: 12),
                            Text(
                              opt['label']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF05354C),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Icon(Icons.volume_up,
                                size: 18, color: Color(0xFF05354C)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _BottomActionArea(
          enabled: _selected != null,
          checked: _checked,
          onCheck: _check,
          onNext: _next,
          rightAnswer: 'Kitchen',
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════
// TASK 3 — Pair Words
// ═══════════════════════════════════════════
class _Task3PairWords extends StatefulWidget {
  final VoidCallback onComplete;
  final VoidCallback onWrong;

  const _Task3PairWords({
    super.key,
    required this.onComplete,
    required this.onWrong,
  });

  @override
  State<_Task3PairWords> createState() => _Task3PairWordsState();
}

class _Task3PairWordsState extends State<_Task3PairWords> {
  static const _pairs = {
    'Ambo': "I'am",
    'Home': 'Rumah',
    'Dapua': 'Kitchen',
    'Jawi': 'Cow',
    'Hungry': 'Lapa',
  };

  late final List<String> _leftWords;
  late final List<String> _rightWords;

  int? _selectedLeft;
  int? _selectedRight;
  final Map<int, int> _matched = {};
  bool? _checked;

  @override
  void initState() {
    super.initState();
    _leftWords = _pairs.keys.toList();
    _rightWords = ["I'am", "Cow", "Lapa", "Kitchen", "Rumah"];
  }

  void _selectLeft(int i) {
    if (_matched.containsKey(i)) return;
    setState(() => _selectedLeft = i);
    _tryMatch();
  }

  void _selectRight(int i) {
    if (_matched.values.contains(i)) return;
    setState(() => _selectedRight = i);
    _tryMatch();
  }

  void _tryMatch() {
    if (_selectedLeft == null || _selectedRight == null) return;

    final left = _selectedLeft!;
    final right = _selectedRight!;
    final isCorrect = _pairs[_leftWords[left]] == _rightWords[right];

    setState(() {
      if (isCorrect) _matched[left] = right;
      _selectedLeft = null;
      _selectedRight = null;
      if (_matched.length == _pairs.length) _checked = true;
    });

    if (!isCorrect) widget.onWrong();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pair the matching word correctly',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: _leftWords.asMap().entries.map((e) {
                          final isMatched = _matched.containsKey(e.key);
                          return GestureDetector(
                            onTap: isMatched
                                ? null
                                : () => _selectLeft(e.key),
                            child: _PairPill(
                              label: e.value,
                              isSelected: _selectedLeft == e.key,
                              isMatched: isMatched,
                              hideLabel: isMatched,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: _rightWords.asMap().entries.map((e) {
                          final isMatched = _matched.values.contains(e.key);
                          return GestureDetector(
                            onTap: isMatched
                                ? null
                                : () => _selectRight(e.key),
                            child: _PairPill(
                              label: e.value,
                              isSelected: _selectedRight == e.key,
                              isMatched: isMatched,
                              hideLabel: isMatched,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _BottomActionArea(
          enabled: _checked == true,
          checked: _checked,
          onCheck: widget.onComplete,
          onNext: widget.onComplete,
          rightAnswer: '',
          forceText: 'Check',
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════
// SHARED WIDGETS
// ═══════════════════════════════════════════
class _QuestionCard extends StatelessWidget {
  final String petAsset;
  final String word;
  const _QuestionCard({required this.petAsset, required this.word});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Color(0xFFF9F3EA),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(
              petAsset,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.pets, size: 40),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF05354C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        word,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -6,
                    top: 24,
                    child: Transform.rotate(
                      angle: math.pi / 4,
                      child: Container(
                        width: 14,
                        height: 14,
                        color: const Color(0xFF05354C),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.only(left: 12),
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFE6F5FE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.volume_up,
                    size: 20, color: Color(0xFF004D73)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFBDBDBD)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 8.0;
    const dashSpace = 6.0;
    final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16));

    final path = Path()..addRRect(rrect);
    final pathMetrics = path.computeMetrics();

    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        canvas.drawPath(
            pathMetric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ✅ FIX UTAMA: width null saat isSelected agar muncul di dalam Row
class _WordPill extends StatelessWidget {
  final String word;
  final bool isSelected;
  const _WordPill({required this.word, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      // ✅ isSelected (dalam Row horizontal) → auto width
      // ✅ !isSelected (dalam GridView) → full width
      width: isSelected ? null : double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE6F5FE) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF004D73)
              : const Color(0xFFE0E0E0),
          width: 1.5,
        ),
        boxShadow: [
          if (!isSelected)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Text(
        word,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: isSelected ? const Color(0xFF004D73) : Colors.black87,
        ),
      ),
    );
  }
}

class _PairPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isMatched;
  final bool hideLabel;

  const _PairPill({
    required this.label,
    required this.isSelected,
    required this.isMatched,
    this.hideLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = const Color(0xFFE6F5FE);
    Color bgColor = Colors.white;
    Color textColor = Colors.black87;

    if (isMatched) {
      borderColor = const Color(0xFF1EA36D);
      bgColor = const Color(0xFFEBFFF5);
      textColor = Colors.transparent;
    } else if (isSelected) {
      borderColor = const Color(0xFF004D73);
      bgColor = const Color(0xFFE6F5FE);
      textColor = const Color(0xFF004D73);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Center(
        child: isMatched
            ? const Icon(Icons.check_rounded,
                color: Color(0xFF1EA36D), size: 22)
            : Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// BOTTOM ACTION AREA
// ═══════════════════════════════════════════
class _BottomActionArea extends StatelessWidget {
  final bool enabled;
  final bool? checked;
  final VoidCallback onCheck;
  final VoidCallback onNext;
  final String rightAnswer;
  final String? forceText;

  const _BottomActionArea({
    required this.enabled,
    required this.checked,
    required this.onCheck,
    required this.onNext,
    required this.rightAnswer,
    this.forceText,
  });

  @override
  Widget build(BuildContext context) {
    if (checked == null) {
      return Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: enabled ? onCheck : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: enabled
                  ? const Color(0xFF1EA36D)
                  : const Color(0xFFAFAFAF),
              disabledBackgroundColor: const Color(0xFFAFAFAF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
            ),
            child: Text(
              forceText ?? 'Check',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      );
    }

    final isCorrect = checked == true;
    final color =
        isCorrect ? const Color(0xFF1EA36D) : const Color(0xFFE23D3D);
    final icon = isCorrect ? Icons.check : Icons.close;
    final title = isCorrect ? 'You did Great!' : 'Wrong';
    final btnText = isCorrect ? 'Continue' : 'Oke';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          if (!isCorrect) ...[
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 16, color: Color(0xFFE23D3D)),
                children: [
                  const TextSpan(text: 'Right Answer : '),
                  TextSpan(
                    text: rightAnswer,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
              ),
              child: Text(
                btnText,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// LESSON COMPLETE SCREEN
// ═══════════════════════════════════════════
class _LessonCompleteScreen extends StatelessWidget {
  final String petAsset;
  final VoidCallback onContinue;

  const _LessonCompleteScreen({
    required this.petAsset,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            ClipPath(
              clipper: _LessonCompleteWaveClipper(),
              child: Container(
                height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF42E0FF),
                      Color(0xFFF1F9FF),
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('✨ ',
                          style: TextStyle(
                              fontSize: 32, color: Color(0xFFF89B29))),
                      Text(
                        'Lesson Complete!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFF89B29),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "You're doing great, keep it up!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF05354C),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFF6ED),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF89B29).withOpacity(0.15),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        petAsset,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        errorBuilder: (_, __, ___) => const Icon(
                            Icons.pets,
                            size: 100,
                            color: Color(0xFFF89B29)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: const [
                        Expanded(
                          child: _FinalStatCard(
                            icon: Icons.bolt_rounded,
                            iconColor: Color(0xFFF89B29),
                            label: 'Total XP',
                            value: '+20',
                            valueColor: Color(0xFFF89B29),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _FinalStatCard(
                            icon: Icons.adjust_rounded,
                            iconColor: Color(0xFF1EA36D),
                            label: 'Correct',
                            value: '100%',
                            valueColor: Color(0xFF1EA36D),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _FinalStatCard(
                            icon: Icons.access_time_filled_rounded,
                            iconColor: Color(0xFF00334E),
                            label: 'Time',
                            value: '2:30',
                            valueColor: Color(0xFF00334E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: onContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1EA36D),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
    );
  }
}

class _FinalStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color valueColor;

  const _FinalStatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAF8F5), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9E9E9E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// CLIPPERS
// ═══════════════════════════════════════════
class _HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(size.width * 0.25, size.height + 10,
        size.width * 0.5, size.height - 10);
    path.quadraticBezierTo(size.width * 0.75, size.height - 30,
        size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _LessonCompleteWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width * 0.25, size.height + 20,
        size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(size.width * 0.75, size.height - 60,
        size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
