import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServicePro {
  final String baseUrl = 'http://192.168.215.204:5000/auth';

  // Login user
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});

    try {
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['token'] != null) {
        await saveToken(data['token']);
        return {'success': true, 'message': 'Login berhasil', 'data': data};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Login gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Kesalahan jaringan saat login: $e',
      };
    }
  }

  // Simpan token ke SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
  }

  // Ambil token dari SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  // Logout dan bersihkan token + data user
  Future<bool> logout() async {
    final token = await getToken();
    final url = Uri.parse('$baseUrl/logout');
    final headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await http.post(url, headers: headers);
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Hapus semua data

      return response.statusCode == 200;
    } catch (e) {
      // Tetap bersihkan lokal meskipun gagal logout dari server
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return false;
    }
  }

  // Ambil data profil user dari backend
  Future<Map<String, dynamic>> fetchUserProfile(int userId) async {
    final token = await getToken();

    if (token == null || token.isEmpty) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login ulang.',
      };
    }

    final url = Uri.parse('$baseUrl/profile');
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    try {
      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userData = data['data'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', userData['id'] ?? 0);
        await prefs.setString('user_name', userData['name'] ?? '');
        await prefs.setString('user_email', userData['email'] ?? '');
        await prefs.setString('user_gender', userData['gender'] ?? '');
        await prefs.setInt(
          'user_age',
          int.tryParse(userData['usia'].toString()) ?? 0,
        );
        await prefs.setString('user_avatar', '');

        return {
          'success': true,
          'message': 'Profil berhasil diambil',
          'data': userData,
        };
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        await logout();
        return {
          'success': false,
          'message': 'Sesi login kedaluwarsa. Silakan login ulang.',
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              data['message'] ?? 'Terjadi kesalahan saat mengambil profil.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan jaringan: $e',
      };
    }
  }
}
