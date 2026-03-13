import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = 'https://api-lingupet.onrender.com/api/auth';
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'auth_user';

  // ── REGISTER ──────────────────────────────────
  static Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/register/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': username,
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Simpan token jika langsung dikembalikan saat register
        if (data['token'] != null) {
          await _saveSession(token: data['token'], user: data['user'] ?? data);
        }
        return AuthResult.success(data);
      }

      // Ekstrak pesan error dari response
      return AuthResult.error(_extractError(data));
    } on http.ClientException {
      return AuthResult.error('Tidak dapat terhubung ke server. Periksa koneksi internet.');
    } catch (e) {
      return AuthResult.error('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  // ── LOGIN ──────────────────────────────────────
  static Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/login/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Simpan token & data user ke SharedPreferences
        final token = data['token'] ??
            data['access'] ??
            data['access_token'] ??
            data['data']?['token'];
        final user = data['user'] ?? data['data'] ?? data;

        if (token != null) {
          await _saveSession(token: token, user: user);
        }
        return AuthResult.success(data);
      }

      return AuthResult.error(_extractError(data));
    } on http.ClientException {
      return AuthResult.error('Tidak dapat terhubung ke server. Periksa koneksi internet.');
    } catch (e) {
      return AuthResult.error('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  // ── LOGOUT ────────────────────────────────────
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  // ── GET TOKEN ─────────────────────────────────
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // ── IS LOGGED IN ──────────────────────────────
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ── GET SAVED USER ────────────────────────────
  static Future<Map<String, dynamic>?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userKey);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  // ── PRIVATE HELPERS ───────────────────────────
  static Future<void> _saveSession({
    required String token,
    required dynamic user,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, jsonEncode(user));
  }

  static String _extractError(dynamic data) {
    if (data is Map) {
      // Coba berbagai key error umum dari DRF / custom API
      for (final key in [
        'message',
        'error',
        'detail',
        'non_field_errors',
        'email',
        'password',
        'username',
      ]) {
        if (data[key] != null) {
          final val = data[key];
          if (val is List) return val.first.toString();
          return val.toString();
        }
      }
      return data.toString();
    }
    return 'Terjadi kesalahan tidak dikenal.';
  }
}

// ── RESULT MODEL ──────────────────────────────
class AuthResult {
  final bool isSuccess;
  final String? errorMessage;
  final Map<String, dynamic>? data;

  AuthResult._({
    required this.isSuccess,
    this.errorMessage,
    this.data,
  });

  factory AuthResult.success(Map<String, dynamic> data) =>
      AuthResult._(isSuccess: true, data: data);

  factory AuthResult.error(String message) =>
      AuthResult._(isSuccess: false, errorMessage: message);
}
