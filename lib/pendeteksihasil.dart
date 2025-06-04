import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dashboard.dart';
import 'konsultasi.dart';
import 'profile.dart';
import 'pendeteksi.dart';

class PendeteksiHasilPage extends StatelessWidget {
  final double hasilPersentase;
  final String hasilStatus;

  const PendeteksiHasilPage({
    Key? key,
    required this.hasilPersentase,
    required this.hasilStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF1CF),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFF8A4E4E),
            size: 28,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PendeteksiPage()),
            );
          },
        ),
        titleSpacing: 0,
        title: const Text(
          'Pendeteksi',
          style: TextStyle(
            color: Color(0xFF8A4E4E),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'lib/assets/heartguardnobg.png',
                  height: 36,
                ),
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7D6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF8A4E4E),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 200,
                          color: Colors.red.shade300,
                        ),
                        Text(
                          '${hasilPersentase.toInt()}%',
                          style: const TextStyle(
                            color: Color(0xFF8A4E4E),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      hasilStatus,
                      style: const TextStyle(
                        color: Color(0xFF8A4E4E),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
