import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Background putih
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                // Logo kecil atas
                Row(
                  children: [
                    Image.asset(
                      'lib/assets/heartguardnobg.png', // Logo kecil
                      height: 32,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'HeGu',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Color(0xFF8A4E4E),
                        letterSpacing: 1.2, // kasih jarak antar huruf
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 1,
                            color: Color(0x55000000), // shadow halus
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Logo besar tengah
                Image.asset(
                  'lib/assets/heartguard.png',
                  height: 260,
                ),
                const SizedBox(height: 30),
                // Card utama
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF9D9), // warna krem soft
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Selamat Datang di HeartGuard!',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8A4E4E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Ingin memantau kesehatan jantung dengan mudah?\nCek kesehatanmu sekarang dengan Hegu! 🤎',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8A4E4E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Tombol Masuk & Masuk Via Email (sejajar)
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF8A4E4E),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const Register()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side:
                                    const BorderSide(color: Color(0xFF8A4E4E)),
                                minimumSize: const Size(double.infinity, 50),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8A4E4E),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Tombol SignUp
                      // OutlinedButton(
                      //   onPressed: () {
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute(
                      //           builder: (context) => const Register()),
                      //     );
                      //   },
                      //   style: OutlinedButton.styleFrom(
                      //     side: const BorderSide(color: Color(0xFF8A4E4E)),
                      //     minimumSize: const Size(double.infinity, 50),
                      //     padding: const EdgeInsets.symmetric(vertical: 14),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     backgroundColor: Colors.white,
                      //   ),
                      //   child: const Text(
                      //     'SignUp',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       color: Color(0xFF8A4E4E),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Dengan Masuk dan Daftar kamu menyetujui\nKeamanan dan layanan Kebijakan Privasi',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF8A4E4E),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
