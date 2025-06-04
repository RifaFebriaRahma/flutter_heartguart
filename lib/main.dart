import 'package:flutter/material.dart';
import 'package:flutter_heartguart/onboardingpage.dart';
import 'package:flutter_heartguart/splashscreen.dart';
import 'package:flutter_heartguart/login.dart';
import 'package:flutter_heartguart/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),

      // Tambah routing supaya bisa navigasi pakai named route
      routes: {
        '/onboarding': (context) => const OnBoardingPage(),
        '/login': (context) => const Login(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
