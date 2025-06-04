import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'onboardingpage.dart';
import 'login.dart';
import '../services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _email = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();
  final _usia = TextEditingController();
  final _gender = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  Future<void> addNewUsers() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // cek email dulu lewat service
      final emailExists =
          await _authService.checkEmailExists(_email.text.trim());

      if (emailExists) {
        showSnackBar("Email sudah terdaftar!");
        setState(() => _isLoading = false);
        return;
      }

      // register via service
      final result = await _authService.register(
        name: _name.text.trim(),
        email: _email.text.trim(),
        password: _password.text.trim(),
        usia: int.tryParse(_usia.text.trim()) ?? 0,
        gender: _gender.text.trim(),
      );

      if (result['success'] == true) {
        showSnackBar("Register berhasil! Mengarahkan ke Login...");
        await Future.delayed(const Duration(seconds: 1));
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        showSnackBar(result['message'] ?? 'Gagal registrasi');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Registration error: $e");
      }
      showSnackBar("Terjadi kesalahan saat registrasi.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _name.dispose();
    _password.dispose();
    _usia.dispose();
    _gender.dispose();
    super.dispose();
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
      errorStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnBoardingPage()),
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
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xFF8A4E4E),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 4, left: 2),
                  child: Text(
                    'Lengkapi data diri dibawah ini',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8A4E4E),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                        controller: _name,
                        decoration: _inputDecoration('Nama Lengkap'),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Masukkan nama lengkap'
                            : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _usia,
                        decoration: _inputDecoration('Usia'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan usia';
                          }
                          final usia = int.tryParse(value);
                          if (usia == null || usia <= 0) {
                            return 'Usia tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _gender,
                        decoration: _inputDecoration('Jenis Kelamin'),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Masukkan jenis kelamin'
                            : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _email,
                        decoration: _inputDecoration('Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Masukkan email yang valid';
                          }
                          return null;
                        },
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
                      const SizedBox(height: 40),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: addNewUsers,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8A4E4E),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Lanjutkan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah punya akun? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text(
                      'Masuk disini',
                      style: TextStyle(
                        color: Color(0xFF8A4E4E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
