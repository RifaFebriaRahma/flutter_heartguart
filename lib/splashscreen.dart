import 'dart:async';
import 'package:flutter/material.dart';
import 'onboardingpage.dart'; // Ganti dengan halaman tujuan setelah splash

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) =>
                const OnBoardingPage()), // Ganti sesuai halaman utama kamu
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 247, 204),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/heartguardnobg.png', // Ganti dengan nama file asset yang sesuai
              height: 250,
            ),
            const SizedBox(height: 12),
            // const Text(
            //   "HeartGuard",
            //   style: TextStyle(
            //     fontSize: 18,
            //     color: Color(0xFF8A4E4E),
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
