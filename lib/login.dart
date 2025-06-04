import 'dart:convert';
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'register.dart';
import 'onboardingpage.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

Future<void> saveUserDataToPrefs(Map<String, dynamic> userData) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_id', userData['id'].toString());
  await prefs.setString('user_name', userData['name'] ?? '');
  await prefs.setString('user_email', userData['email'] ?? '');
  await prefs.setString('user_gender', userData['gender'] ?? '');
  await prefs.setInt('user_age', userData['age'] ?? 0);
  await prefs.setString('user_avatar', userData['avatarUrl'] ?? '');
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  bool isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      try {
        final result = await _authService.login(
          _email.text.trim(),
          _password.text,
        );

        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        if (result['success'] == true) {
          final userData = result['user'];
          if (userData != null && userData is Map<String, dynamic>) {
            await saveUserDataToPrefs(userData);

            // Tambahan eksplisit simpan user_id
            final prefs = await SharedPreferences.getInstance();
            await prefs.setInt('user_id', userData['id']); // Simpan ID user

            print("Login sukses, data user tersimpan: $userData"); // Debug
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardPage()),
          );
        } else {
          _showError(result['message'] ?? 'Gagal login.');
        }
      } catch (e) {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        _showError('Terjadi kesalahan: $e');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Color(0xFF8A4E4E),
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8A4E4E), width: 4),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8A4E4E), width: 4),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8A4E4E), width: 4),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF8A4E4E), width: 4),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnBoardingPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chevron_left,
                        color: Color(0xFF8A4E4E), size: 28),
                  ),
                  Image.asset('lib/assets/heartguardnobg.png', height: 36),
                  const SizedBox(width: 6),
                  const Text(
                    'HeGu',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Color(0xFF8A4E4E),
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 1,
                          color: Color(0x55000000),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF8A4E4E),
                        )),
                    SizedBox(height: 4),
                    Text('Masukkan email yang terdaftar.',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF8A4E4E))),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5C3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _email,
                        decoration: _inputDecoration('Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Masukkan email yang valid';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration: _inputDecoration('Password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan password';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 230),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8A4E4E),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Lanjutkan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    },
                    child: const Text(
                      'Register disini',
                      style: TextStyle(
                        color: Color(0xFF8A4E4E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
