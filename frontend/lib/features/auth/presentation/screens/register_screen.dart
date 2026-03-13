import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingupet/core/constants/app_assets.dart';
import 'package:lingupet/core/services/auth_service.dart';
import 'auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _isLoading = false;
  String? _errorMsg;

  String? _validate() {
    final username = _usernameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;

    if (username.isEmpty) return 'Username tidak boleh kosong.';
    if (username.length < 3) return 'Username minimal 3 karakter.';
    if (email.isEmpty) return 'Email tidak boleh kosong.';
    if (!RegExp(r'^[\w\-.]+@[\w\-]+\.[a-z]{2,}$').hasMatch(email)) {
      return 'Format email tidak valid.';
    }
    if (pass.isEmpty) return 'Password tidak boleh kosong.';
    if (pass.length < 6) return 'Password minimal 6 karakter.';
    return null;
  }

  Future<void> _register() async {
    final validErr = _validate();
    if (validErr != null) {
      setState(() => _errorMsg = validErr);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });

    final result = await AuthService.register(
      username: _usernameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result.isSuccess) {
      final savedEmail = _emailCtrl.text.trim();
      final savedPass = _passCtrl.text;
      await _showSuccessDialog(savedEmail, savedPass);
    } else {
      setState(() => _errorMsg = result.errorMessage);
    }
  }

  Future<void> _showSuccessDialog(String email, String password) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Ikon Sukses ──
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F8F0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF2ECC71),
                  size: 42,
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Akun Berhasil Dibuat!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                'Silakan login dengan akun yang baru saja kamu daftarkan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B8499),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // ── Info Email ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F8FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD0E8F8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.alternate_email_rounded,
                            size: 14, color: Color(0xFF6B8499)),
                        SizedBox(width: 6),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF6B8499),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Tombol Login Sekarang ──
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.go(
                      '/login',
                      extra: {
                        'email': email,
                        'password': password,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5A623),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Login Sekarang',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6EEF8),
      body: SafeArea(
        child: Stack(
          children: [
            // ── Dekorasi ──
            Positioned(
              left: 12,
              bottom: 60,
              child: Icon(Icons.language_rounded,
                  size: 32,
                  color: const Color(0xFF38D1F5).withOpacity(0.5)),
            ),
            Positioned(
              right: 16,
              top: 180,
              child: Text(
                'あ',
                style: TextStyle(
                    fontSize: 28,
                    color: const Color(0xFF38D1F5).withOpacity(0.35),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              right: 20,
              top: 60,
              child: Icon(Icons.star_border_rounded,
                  size: 26,
                  color: const Color(0xFF38D1F5).withOpacity(0.5)),
            ),

            // ── Konten Utama ──
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TOP BAR
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.go('/login'),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                        const SizedBox(width: 38),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // MASCOT
                    Center(
                      child: Image.asset(
                        AppAssets.welcome,
                        height: 165,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // JUDUL
                    const Text(
                      'Start Your Adventure!',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1A1A2E),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Help protect regional languages with Wiraga.',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF6B8499),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // USERNAME
                    const FieldLabel(text: 'Username'),
                    const SizedBox(height: 8),
                    InputField(
                      controller: _usernameCtrl,
                      hint: 'username',
                      icon: Icons.person_outline_rounded,
                    ),

                    const SizedBox(height: 16),

                    // EMAIL
                    const FieldLabel(text: 'Email'),
                    const SizedBox(height: 8),
                    InputField(
                      controller: _emailCtrl,
                      hint: 'name@email.com',
                      icon: Icons.alternate_email_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    // PASSWORD
                    const FieldLabel(text: 'Password'),
                    const SizedBox(height: 8),
                    InputField(
                      controller: _passCtrl,
                      hint: '••••••••',
                      icon: Icons.lock_outline_rounded,
                      obscure: _obscurePass,
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            setState(() => _obscurePass = !_obscurePass),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            _obscurePass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFFB0BEC5),
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    // ERROR BOX
                    if (_errorMsg != null) ...[
                      const SizedBox(height: 12),
                      ErrorBox(message: _errorMsg!),
                    ],

                    const SizedBox(height: 24),

                    // REGISTER BUTTON
                    OrangeButton(
                      label: 'Register',
                      isLoading: _isLoading,
                      onPressed: _register,
                    ),

                    const SizedBox(height: 22),

                    // LOGIN LINK
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(
                            color: Color(0xFF6B8499),
                            fontSize: 13,
                          ),
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () => context.go('/login'),
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Color(0xFFF5A623),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
