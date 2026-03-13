import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class BuildVocabularyPage extends StatefulWidget {
  const BuildVocabularyPage({Key? key}) : super(key: key);

  @override
  State<BuildVocabularyPage> createState() => _BuildVocabularyPageState();
}

class _BuildVocabularyPageState extends State<BuildVocabularyPage>
    with SingleTickerProviderStateMixin {
  final _recorder = AudioRecorder();
  final _wordController = TextEditingController();

  bool _isRecording = false;
  bool _hasRecording = false;
  String? _recordingPath;
  Duration _recordDuration = Duration.zero;

  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    _wordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _recorder.dispose();
    _wordController.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  // ── Recording logic ──
  Future<void> _toggleRecording() async {
    _isRecording ? await _stopRecording() : await _startRecording();
  }

  Future<void> _startRecording() async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      _showSnack('Microphone permission denied');
      return;
    }
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/vocab_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(const RecordConfig(), path: path);
    setState(() {
      _isRecording = true;
      _hasRecording = false;
      _recordingPath = path;
      _recordDuration = Duration.zero;
    });
    _pulseCtrl.repeat(reverse: true);
    _tickDuration();
  }

  void _tickDuration() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted || !_isRecording) return false;
      setState(() => _recordDuration += const Duration(seconds: 1));
      return true;
    });
  }

  Future<void> _stopRecording() async {
    final path = await _recorder.stop();
    _pulseCtrl
      ..stop()
      ..reset();
    setState(() {
      _isRecording = false;
      _hasRecording = path != null;
      _recordingPath = path;
    });
  }

  void _resetRecording() {
    setState(() {
      _hasRecording = false;
      _recordingPath = null;
      _recordDuration = Duration.zero;
    });
  }

  // ── Submit ──
  bool get _canSubmit =>
      _wordController.text.trim().isNotEmpty && _hasRecording;

  void _submit() {
    if (!_canSubmit) return;
    // TODO: kirim _wordController.text & _recordingPath ke API
    _showSnack('Vocabulary sent! 🎉');
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) Navigator.pop(context);
    });
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)));
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  // ══════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          // ── HEADER ──
          Stack(
            children: [
              ClipPath(
                clipper: HeaderWaveClipper(),
                child: Container(
                  height: 320,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.petBabyBg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 20,
              //   left: 0,
              //   right: 0,
              //   // child: Center(
              //   //   child: Image.asset(AppAssets.petBaby,
              //   //       height: 180, fit: BoxFit.contain),
              //   // ),
              // ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _circleBtn(
                        icon: Icons.close,
                        onTap: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Build Vocabulary',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00334E))),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('🇮🇩 ', style: TextStyle(fontSize: 12)),
                                Text('West Sumatra, Indonesia',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF4A4A4A),
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── CONTENT ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('How do you say this sentence in Minang?',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),
                  const SizedBox(height: 16),

                  // Chat Bubble
                  Stack(
                    children: [
                      Positioned(
                        top: 2,
                        left: 20,
                        child: Transform.rotate(
                          angle: 45 * math.pi / 180,
                          child: Container(
                              width: 20,
                              height: 20,
                              color: const Color(0xFF05354C)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            color: const Color(0xFF05354C),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text('I am Hungry',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ── Local Word Input ──
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Local Word',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4A4A4A))),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: TextField(
                            controller: _wordController,
                            decoration: const InputDecoration(
                              hintText: 'Write the word in the Minang accent',
                              hintStyle: TextStyle(
                                  color: Color(0xFFBDBDBD), fontSize: 14),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Record Voice ──
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Record Your Voice',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4A4A4A))),
                        const SizedBox(height: 20),

                        // Mic button with pulse animation
                        GestureDetector(
                          onTap: _toggleRecording,
                          child: _isRecording
                              ? AnimatedBuilder(
                                  animation: _pulseAnim,
                                  builder: (_, __) => Transform.scale(
                                    scale: _pulseAnim.value,
                                    child: _micCircle(isActive: true),
                                  ),
                                )
                              : _micCircle(isActive: false),
                        ),

                        const SizedBox(height: 16),

                        // Status text
                        if (_isRecording) ...[
                          Text(
                            '● Recording  ${_fmt(_recordDuration)}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFEF4444)),
                          ),
                          const SizedBox(height: 8),
                          const Text('Tap to stop',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF9CA3AF))),
                        ] else if (_hasRecording) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle_rounded,
                                  color: Color(0xFF1EA36D), size: 20),
                              const SizedBox(width: 6),
                              Text(
                                'Recorded  ${_fmt(_recordDuration)}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1EA36D)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Re-record button
                          GestureDetector(
                            onTap: _resetRecording,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: const Color(0xFFEF4444)),
                              ),
                              child: const Text('Re-record',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFEF4444),
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ] else ...[
                          const Text('Tap to start recording',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF757575))),
                        ],

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // ── SEND BUTTON ──
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _canSubmit ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1EA36D),
                    disabledBackgroundColor: const Color(0xFFAFAFAF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: _canSubmit ? 4 : 0,
                  ),
                  child: const Text('Send Vocabulary',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helper Widgets ──
  Widget _micCircle({required bool isActive}) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFFFFEBEB) : const Color(0xFFE8FDF5),
        boxShadow: [
          BoxShadow(
            color:
                (isActive ? const Color(0xFFEF4444) : const Color(0xFF1EA36D))
                    .withOpacity(0.25),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(
        isActive ? Icons.stop_rounded : Icons.mic_rounded,
        color: isActive ? const Color(0xFFEF4444) : const Color(0xFF1EA36D),
        size: 36,
      ),
    );
  }

  Widget _circleBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
          ],
        ),
        child: Icon(icon, color: const Color(0xFF00334E), size: 20),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEAEAEA)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.01),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: child,
    );
  }
}

class HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width * 0.25, size.height, size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 40, size.width, size.height - 15);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
