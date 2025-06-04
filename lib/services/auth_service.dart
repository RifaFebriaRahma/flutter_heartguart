import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl =
      'http://192.168.215.204:5000/auth'; // Ganti sesuai IP server-mu

  /// LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': email.trim(),
      'password': password.trim(),
    });

    try {
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Login berhasil',
          'data': data['data'] ?? {},
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Login gagal',
        };
      }
    } catch (e) {
      log("Login error: $e");
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }

  /// REGISTER
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required int usia,
    required String gender,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'usia': usia,
      'gender': gender.trim(),
    });

    try {
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Registrasi berhasil',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Registrasi gagal',
        };
      }
    } catch (e) {
      log("Register error: $e");
      return {
        'success': false,
        'message': 'Terjadi kesalahan saat registrasi: $e',
      };
    }
  }

  /// CEK EMAIL
  Future<bool> checkEmailExists(String email) async {
    final url =
        Uri.parse('$baseUrl/check-email'); // pakai dash, bukan underscore
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email.trim()});

    try {
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['exists'] == true;
      } else {
        log("Cek email response bukan 200: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log('Cek email gagal: $e');
      return false;
    }
  }
}
